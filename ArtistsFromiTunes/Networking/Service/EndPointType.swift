//
//  EndPointType.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

extension EndPointType {
    
    var environmentBaseURL : String {
        return "https://itunes.apple.com/"
    }
    
}
