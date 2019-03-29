//
//  ArtistState.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift
import ReSwiftThunk

public struct ArtistState: StateType {
  public var artist: Artist?
  public var albums: [Album]
}

extension ArtistState {
  struct Reducer {
    static func handleAction(action: ReSwift.Action, state: ArtistState?) -> ArtistState {
      var state = state ?? ArtistState(artist: nil, albums: [])
      guard let action = action as? Actions else {
        return state
      }
      switch action {
      case .setArtist(let artist):
        state.artist = artist
      case .setAlbums(let albums):
        state.albums = albums
      case .loadAlbums(_):
        break
      }
      return state
    }
  }
  
  enum Actions: Action {
    case setArtist(Artist)
    case setAlbums([Album])
    case loadAlbums(artistMbid: String)
  }
  
  enum ActionCreators {
    static func selectArtist(_ artist: Artist) -> Thunk<AppState> {
      return Thunk<AppState> { dispatch, _ in
        dispatch(ArtistState.Actions.setAlbums([]))
        dispatch(Actions.loadAlbums(artistMbid: artist.mbid))
        dispatch(Actions.setArtist(artist))
      }
    }
  }
}
