//
//  ArtistsReducer.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 4/1/19.
//  Copyright © 2019 Ciklum. All rights reserved.
//

import ReSwift

extension ArtistsState {
  struct Reducer {
    static func handleAction(action: Action, state: ArtistsState?) -> ArtistsState {
      var state = state ?? ArtistsState(artists: [], country: .ukraine)
      guard let action = action as? Actions else {
        return state
      }
      switch action {
      case .setArtists(let artists):
        state.artists = artists
      case .setCountry(let country):
        state.country = country
      case .loadArtists(_):
        break
      }
      return state
    }
  }
  
  enum Actions: Action {
    case setArtists([Artist])
    case setCountry(Country)
    case loadArtists(Country)
  }
}
