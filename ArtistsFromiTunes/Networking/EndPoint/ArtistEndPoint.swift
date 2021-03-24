//
//  ArtistEndPoint.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

enum ArtistApi {
    case tracks(artistName: String)
}

extension ArtistApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .tracks(_):
            return "search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .tracks(_):
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .tracks(let artistName):
            let urlParameters = ["term": artistName]
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: ParameterEncoding.urlEncoding,
                                                urlParameters: urlParameters,
                                                additionHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .tracks(_):
            return ["Content-Type":"application/json"]
        }
    }
}
