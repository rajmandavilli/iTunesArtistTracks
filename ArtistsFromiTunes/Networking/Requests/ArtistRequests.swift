//
//  ArtistRequests.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

protocol ArtistRequests {
    static func getTracks(artistName: String, completion: @escaping (Result<TracksJSON, Error>)->Void)
}

struct LiveArtistRequests: ArtistRequests {
    
    static func getTracks(artistName: String, completion: @escaping (Result<TracksJSON, Error>) -> Void) {
        let router = Router<ArtistApi>()
        router.performRequest(route: ArtistApi.tracks(artistName: artistName), completion: completion)
    }
    
}

