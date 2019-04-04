//
//  ArtistsActions.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 4/1/19.
//  Copyright © 2019 Ciklum. All rights reserved.
//

import ReSwift
import ReSwiftThunk

extension ArtistsState {
  public enum ActionCreators {
    public static func didTapOnArtist(at index: Int) -> Thunk<AppState> {
      return Thunk<AppState> { dispatch, getState in
        guard let state = getState() else { return }
        guard let artists = state.artistsState.artists,
          index < artists.count else { fatalError() }
        let artist = artists[index]
        dispatch(AlbumsState.ActionCreators.selectArtist(artist))
      }
    }
    
    public static func loadArtists(for country: Country) -> Thunk<AppState> {
      return Thunk<AppState> { dispatch, getState in
        dispatch(NetworkActions.loadArtists(country))
        dispatch(ArtistsState.Actions.setCountry(country))
      }
    }
  }
}
