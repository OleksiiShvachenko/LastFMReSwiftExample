//
//  CountryArtistsTests.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import XCTest
import ReSwift
@testable import LastFMReduxState

class CountryArtistsTests: XCTestCase {
  
  func testLoadArtistsSuccess() {
    let stubCountry = Country.ukraine
    let api = API.topArtists(for: stubCountry.rawValue)
    let result = StubResult.succes(filename: "ArtistsResult")
    let artistsStub = Stub(result: result, url: api.url, method: api.method)
    let sessionManager = StubSessionManager([artistsStub])
    let store = createStore(sessionManager)
    store.dispatch(CountryArtistsState.Actions.loadArtists(stubCountry))
    XCTAssertTrue(store.state.artistsByCountryState.artists.count > 0)
  }
  
  func testLoadArtistsFailed() {
    let stubCountry = Country.ukraine
    let api = API.topArtists(for: stubCountry.rawValue)
    let error = NetworkError.noInternetConnection("Test")
    let result = StubResult.error(error)
    let artistsStub = Stub(result: result, url: api.url, method: api.method)
    let sessionManager = StubSessionManager([artistsStub])
    let store = createStore(sessionManager)
    store.dispatch(CountryArtistsState.Actions.loadArtists(stubCountry))
    XCTAssertTrue(store.state.artistsByCountryState.artists.count == 0)
    XCTAssertEqual(error.stringValue, store.state.errorState.generalErrorMessage)
  }
  
  func testLoadArtistsAfterCountrySelection() {
    let stubCountry = Country.ukraine
    let api = API.topArtists(for: stubCountry.rawValue)
    let result = StubResult.succes(filename: "ArtistsResult")
    let artistsStub = Stub(result: result, url: api.url, method: api.method)
    let sessionManager = StubSessionManager([artistsStub])
    let store = createStore(sessionManager)
    store.dispatch(CountryArtistsState.ActionCreators.selectCountry(stubCountry))
    XCTAssertEqual(store.state.artistsByCountryState.country.rawValue, stubCountry.rawValue)
    XCTAssertTrue(store.state.artistsByCountryState.artists.count > 0)
  }
  
}
