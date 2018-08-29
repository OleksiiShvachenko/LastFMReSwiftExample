//
//  ArtistTests.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/8/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import XCTest
import ReSwift
@testable import LastFMReduxState

fileprivate extension Artist {
  static func stub() -> Artist {
    return Artist(JSON: [
      "name": "Test",
      "listeners": "0",
      "mbid": "0",
      "image": [["#text": "https://lastfm-img2.akamaized.net/i/u/34s/62d26c6cb4ac4bdccb8f3a2a0fd55421.png",
                 "size": "small"]]
      ]
      )!
  }
}

class ArtistTests: XCTestCase {

  func testLoadAlbumsForSelectedArtistSuccess() {
    let stubArtist = Artist.stub()
    let api = API.topAlbums(for: stubArtist.mbid)
    let result = StubResult.succes(filename: "AlbumsResults")
    let albumsStub = Stub(result: result, url: api.url, method: api.method)
    let sessionManager = StubSessionManager([albumsStub])
    let store = createStore(sessionManager)
    store.dispatch(CountryArtistsState.Actions.setArtists([stubArtist]))
    store.dispatch(CountryArtistsState.ActionCreators.didTapOnArtist(at: 0))
    XCTAssertTrue(store.state.artistAlbumsState.albums.count > 0)
    XCTAssertNotNil(store.state.artistAlbumsState.artist)
  }
  
  func testLoadAlbumsForSelectedArtistFail() {
    let stubArtist = Artist.stub()
    let api = API.topAlbums(for: stubArtist.mbid)
    let error = NetworkError.noInternetConnection("Test")
    let result = StubResult.error(error)
    let albumsStub = Stub(result: result, url: api.url, method: api.method)
    let sessionManager = StubSessionManager([albumsStub])
    let store = createStore(sessionManager)
    store.dispatch(CountryArtistsState.Actions.setArtists([stubArtist]))
    store.dispatch(CountryArtistsState.ActionCreators.didTapOnArtist(at: 0))
    XCTAssertTrue(store.state.artistAlbumsState.albums.count == 0)
    XCTAssertNotNil(store.state.artistAlbumsState.artist)
    XCTAssertNil(store.state.errorState.generalErrorMessage)
  }
  
}
