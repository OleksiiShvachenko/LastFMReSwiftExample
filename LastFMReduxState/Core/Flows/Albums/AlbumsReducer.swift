//
//  AlbumsReducer.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 4/1/19.
//  Copyright © 2019 Ciklum. All rights reserved.
//

import ReSwift

extension AlbumsState {
  struct Reducer {
    static func handleAction(action: ReSwift.Action, state: AlbumsState?) -> AlbumsState {
      var state = state ?? AlbumsState()
      guard let action = action as? Actions else {
        return state
      }
      switch action {
      case .setArtist(let artist):
        state.artist = artist
      case .setAlbums(let albums):
        state.albums = albums
      }
      return state
    }
  }
  
  enum Actions: Action {
    case setArtist(Artist)
    case setAlbums([Album])
  }
}
