//
//  Router.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?

    /*
     ** Perform network request
     */
    func performRequest<T:Decodable>(route: EndPoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let session = URLSession.shared
        
        
        // TODO: network reachability test
        
        
        // perform request
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("statusCode: \(statusCode)")
                    
                    if statusCode != 200, statusCode != 201, statusCode != 202 {
                        switch statusCode {
                            
                        case 400:                           // Bad request
                            completion(.failure(HTTPNetworkError.requestFailure))
                            
                        case 403:                           // forbidden
                            completion(.failure(HTTPNetworkError.forbidden))
                            
                        case 404:                           // Server error
                            completion(.failure(HTTPNetworkError.serverSideError))
                            
                        case 422:                           // Request contained invalid parameters
                            completion(.failure(HTTPNetworkError.parametersInvalid))
                            
                        case 500:                           // server error
                            completion(.failure(HTTPNetworkError.serverSideError))
                            
                        case 504:                           // Gateway Timeout
                            completion(.failure(HTTPNetworkError.gatewayTimeout))
                            
                        default:
                            completion(.failure(HTTPNetworkError.requestFailure))
                        }
                    }
                }

                if let data = data {
                    //print(String(data: data ?? NSData() as Data, encoding: String.Encoding.utf8))
                    if let result = try? JSONDecoder().decode(T.self, from: data) {
                        completion(.success(result))
                    }
                }
            })
        } catch {
            completion(.failure(error))
        }
        
        self.task?.resume()
    }
    
    /*
     ** Build the URL request
     */
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: HTTPNetworkConstants.timeoutInterval)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                print("\n additionalHeaders: \(additionalHeaders)")
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            
            return request
            
        } catch {
            throw error
        }
    }
    
    /*
     ** Configure parameters for building the URL request
     */
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
            print("\n BodyParameters: \(bodyParameters)")
            print("\n urlParameters: \(urlParameters)")
        } catch {
            throw error
        }
    }
    
    /*
     ** Add addl headers when building the URL request
     */
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

}
