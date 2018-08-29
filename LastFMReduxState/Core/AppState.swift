//
//  AppState.swift
//
//  Created by Oleksii Shvachenko.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

public struct AppState: StateType {
  public let artistsByCountryState: CountryArtistsState
  public let artistAlbumsState: ArtistState
  public let errorState: ErrorState
}

extension AppState {
  static func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
      artistsByCountryState: CountryArtistsState.Reducer.handleAction(action: action, state: state?.artistsByCountryState),
      artistAlbumsState: ArtistState.Reducer.handleAction(action: action, state: state?.artistAlbumsState),
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
