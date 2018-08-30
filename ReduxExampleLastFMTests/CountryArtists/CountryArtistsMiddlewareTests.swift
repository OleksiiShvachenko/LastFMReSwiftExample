//
//  CountryArtistsMiddlewareTests.swift
//  ReduxExampleLastFMTests
//
//  Created by Oleksii Shvachenko on 8/30/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import XCTest
import ReSwift
@testable import LastFMReduxState

class CountryArtistsMiddlewareTests: BaseMiddlewareTests {
  func testLoadArtistsMiddleware() {
    let stubCountry = Country.ukraine
    let api = API.topArtists(for: stubCountry.rawValue)
    let error = NetworkError.noInternetConnection("Test")
    let result = StubResult.error(error)
    let artistsStub = Stub(result: result, url: api.url, method: api.method)
    let sessionManager = StubSessionManager([artistsStub])
    sut = loadArtists(service: sessionManager)
    _ = sut(CountryArtistsState.Actions.loadArtists(stubCountry), context)
    guard let action = dispatchedAction as? CountryArtistsState.Actions,
      case .setArtists(let artists) = action else {
        XCTFail("wrong action was dispathced")
        return
    }
    XCTAssertTrue(artists.count > 0)
  }
}
