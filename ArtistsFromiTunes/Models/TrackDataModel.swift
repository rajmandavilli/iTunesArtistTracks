//
//  TrackDataModel.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

struct TracksJSON: Codable {
    let resultCount: Int
    let tracksRaw: [TrackRaw]
    
    enum CodingKeys : String, CodingKey {
        case resultCount = "resultCount"
        case tracksRaw = "results"
    }
}

struct TrackRaw: Codable {
    let wrapperType: String?
    let kind: String?
    let artistViewUrl: String?
    let artistName: String?
    let trackName: String?
    let trackPrice: Double?
    let releaseDate: String?
    let primaryGenreName: String?
}

struct Track {
    let wrapperType: String?
    let kind: String?
    let artistViewUrl: String?
    let artistName: String?
    let trackName: String?
    let trackPrice: Double?
    let releaseDate: Date?
    let primaryGenreName: String?
}
