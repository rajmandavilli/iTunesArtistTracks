//
//  MockArtistRequests.swift
//  ArtistsFromiTunesTests
//
//  Created by Raj Mandavilli on 3/24/21.
//

import Foundation
@testable import ArtistsFromiTunes

class MockArtistRequests: ArtistRequests {
    
    class func getTracks(artistName: String, completion: @escaping (Result<TracksJSON, Error>) -> Void) {
        let testBundle = Bundle(for: self)
        if let url = testBundle.url(forResource: "PinkFloydTracks", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                if let result = try? JSONDecoder().decode(TracksJSON.self, from: data) {
                    completion(.success(result))
                }
            } catch {
                // handle error
            }
        }
    }
    
}
