//
//  ArtistsFromiTunesTests.swift
//  ArtistsFromiTunesTests
//
//  Created by Raj Mandavilli on 3/23/21.
//

import XCTest
@testable import ArtistsFromiTunes

class ArtistsFromiTunesTests: XCTestCase {
    
    let viewModel = ArtistTracksViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchArtistTracks() {
        // Given
        MockArtistRequests.getTracks(artistName: "Pink Floyd", completion: { result in
            switch result {
            case .success(let tracksJSON):
                self.viewModel.getTracksFromJSON(tracksJSON)
            case .failure(let error):
                print(error)
            }
        })
        
        // Then
        XCTAssertEqual(self.viewModel.tracks.count, 50)
    }

}
