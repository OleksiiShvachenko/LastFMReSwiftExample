//
//  NetworkMiddleware.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 8/28/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import ReSwift

enum NetworkActions: Action {
  case loadAlbums(ArtistId)
  case loadArtists(Country)
}

enum NetworkMiddleware {
  
  static func network(service: API) -> Middleware {
    return { network(action: $0, context: $1, service: service) }
  }
  
}

extension NetworkMiddleware {
  // swiftlint:disable cyclomatic_complexity
  private static func network(action: Action,
                              context: MiddlewareContext<AppState>,
                              service: API) -> Action? {
    guard let networkAction = action as? NetworkActions else {
      return action
    }
    switch networkAction {
    case .loadArtists(let country):
      return loadArtists(context: context, service: service, country: country)
    case .loadAlbums(let artistMbid):
      return loadAlbums(context: context, service: service, artistMbid: artistMbid)
    }
  }
}


private func loadArtists(
  context: MiddlewareContext<AppState>,
  service: API,
  country: Country) -> Action? {
  service.topArtists(for: country.rawValue) { (result) in
    switch result {
    case .success(let artists):
      context.dispatch(ArtistsState.Actions.setArtists(artists.artists))
    case .failure(let error):
      break
    }
    
  }
  return nil
}


private func loadAlbums(
  context: MiddlewareContext<AppState>,
  service: API,
  artistMbid: ArtistId) -> Action? {
  service.topAlbums(for: artistMbid.rawValue) { (result) in
    switch result {
    case .success(let albums):
      context.dispatch(AlbumsState.Actions.setAlbums(albums.albums))
    case .failure(let error):
      break
    }
  }
  return nil
}
