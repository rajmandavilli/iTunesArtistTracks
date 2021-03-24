//
//  StringParameterEncoding.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

public struct StringParameterEncoding: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let bodyParametersString = (parameters.compactMap ({ (key: String, value: Any) -> String in
                return "\(key)=\(value)"
            }) as Array).joined(separator: "&")
            let bodyParametersData = Data(bodyParametersString.utf8)
            urlRequest.httpBody = bodyParametersData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
}
