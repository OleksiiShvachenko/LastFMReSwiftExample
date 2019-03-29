//
//  NetworkMiddleware.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 8/28/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import ReSwift

func loadAlbums(service: API) -> Middleware {
  return { loadAlbums(action: $0, context: $1, service: service) } 
}

func loadArtists(service: API) -> Middleware {
  return { loadArtists(action: $0, context: $1, service: service) }
}

private func loadAlbums(action: Action, context: MiddlewareContext<AppState>, service: API) -> Action? {
  guard
    let loadAlbumsAction = action as? ArtistState.Actions,
    case .loadAlbums(let artistMbid) = loadAlbumsAction else {
      return action
  }
  service.topAlbums(for: artistMbid) { (result) in
    switch result {
    case .success(let albums):
      context.dispatch(ArtistState.Actions.setAlbums(albums.albums))
    case .failure(let error):
      context.dispatch(ErrorState.Actions.errorMessage(error.stringValue))
    }
  }
  return nil
}

private func loadArtists(action: Action, context: MiddlewareContext<AppState>, service: API) -> Action? {
  guard
    let loadArtistsAction = action as? CountryArtistsState.Actions,
    case .loadArtists(let country) = loadArtistsAction else {
      return action
  }
  service.topArtists(for: country.rawValue) { (result) in
    switch result {
    case .success(let artists):
      context.dispatch(CountryArtistsState.Actions.setArtists(artists.artists))
    case .failure(let error):
      context.dispatch(ErrorState.Actions.errorMessage(error.stringValue))
    }

  }
  return nil
}
