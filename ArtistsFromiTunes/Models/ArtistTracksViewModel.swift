//
//  ArtistTracksViewModel.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

final class ArtistTracksViewModel: ObservableObject {
    
    @Published private(set) var tracks: [Track] = []
    
    lazy var releaseDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }()

    func fetchTracksForArtist(_ artistName: String) {
        
        LiveArtistRequests.getTracks(artistName: artistName) { result in
            switch result {
            case .success(let tracksJSON):
                self.getTracksFromJSON(tracksJSON)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTracksFromJSON(_ tracksJSON: TracksJSON) {
        clearTracks()
        
        for trackRaw in tracksJSON.tracksRaw {
            
            var releaseDate: Date?
            if let releaseDateString = trackRaw.releaseDate {
                releaseDate = releaseDateFormatter.date(from: releaseDateString)
            }
            
            let track = Track(
                wrapperType: trackRaw.wrapperType,
                kind: trackRaw.kind,
                artistViewUrl: trackRaw.artistViewUrl,
                artistName: trackRaw.artistName,
                trackName: trackRaw.trackName,
                trackPrice: trackRaw.trackPrice,
                releaseDate: releaseDate,
                primaryGenreName: trackRaw.primaryGenreName
            )
            
            tracks.append(track)
        }
    }
    
    func numberOfTracks() -> Int {
        tracks.count
    }
    
    func clearTracks() {
        tracks.removeAll()
    }

}
