//
//  BaseMiddlewareTests.swift
//  ReduxExampleLastFMTests
//
//  Created by Oleksii Shvachenko on 8/30/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import XCTest
import ReSwift
@testable import LastFMReduxState

class BaseMiddlewareTests: XCTestCase {
  var context: MiddlewareContext<AppState>!
  var state: AppState!
  var dispatchedAction: Action?
  var sut: SimpleMiddleware<AppState>!
  let country = Country.ukraine
  
  override func setUp() {
    super.setUp()
    
    state = AppState(
      artistsByCountryState: CountryArtistsState(artists: [], country: country),
      artistAlbumsState: ArtistState(artist: nil, albums: []),
      errorState: ErrorState(generalErrorMessage: nil)
    )
    context = MiddlewareContext(
      dispatch: { self.dispatchedAction = $0 },
      getState: { self.state },
      next: { _ in }
    )
  }
  
  override func tearDown() {
    context = nil
    dispatchedAction = nil
    sut = nil
    
    super.tearDown()
  }
}
