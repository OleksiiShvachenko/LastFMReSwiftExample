//
//  AppState.swift
//
//  Created by Oleksii Shvachenko.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

public struct AppState: StateType {
  public let countryState: CountryArtistsState
  public let artistState: ArtistState
  public let errorState: ErrorState
}

extension AppState {
  static func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
      countryState: CountryArtistsState.Reducer.handleAction(action: action, state: state?.countryState),
      artistState: ArtistState.Reducer.handleAction(action: action, state: state?.artistState),
      errorState: ErrorState.Reducer.handleAction(action: action, state: state?.errorState)
    )
  }
}

public func createStore(_ sessionManager: APIConformable) -> Store<AppState> {
  return Store<AppState>(
    reducer: AppState.appReducer,
    state: nil,
    middleware: [createMiddleware(loadArtists(service: sessionManager)),
                 createMiddleware(loadAlbums(service: sessionManager))]
  )
}
