//
//  AppState.swift
//
//  Created by Oleksii Shvachenko.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift
import ReSwiftThunk

public struct AppState: StateType {
  public let artistsState: ArtistsState
  public let albumsState: AlbumsState
}

extension AppState {
  static func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
      artistsState: ArtistsState.Reducer.handleAction(action: action, state: state?.artistsState),
      albumsState: AlbumsState.Reducer.handleAction(action: action, state: state?.albumsState)
    )
  }
}

public func createStore(_ sessionManager: API) -> Store<AppState> {
  return Store<AppState>(
    reducer: AppState.appReducer,
    state: nil,
    middleware: [
      createMiddleware(loadArtists(service: sessionManager)),
      createMiddleware(loadAlbums(service: sessionManager)),
      createThunksMiddleware()
    ]
  )
}
