//
//  AlbumsActionCreators.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 4/1/19.
//  Copyright © 2019 Ciklum. All rights reserved.
//

import ReSwift
import ReSwiftThunk

extension AlbumsState {
  enum ActionCreators {
    static func selectArtist(_ artist: Artist) -> Thunk<AppState> {
      return Thunk<AppState> { dispatch, _ in
        dispatch(AlbumsState.Actions.setAlbums([]))
        dispatch(NetworkActions.loadAlbums(artist.mbid))
        dispatch(Actions.setArtist(artist))
      }
    }
  }
}
