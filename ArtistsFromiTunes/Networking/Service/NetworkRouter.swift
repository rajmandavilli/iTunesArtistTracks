//
//  NetworkRouter.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    
    func performRequest<T:Decodable>(route: EndPoint, completion: @escaping (Result<T, Error>) -> Void)
    
}
