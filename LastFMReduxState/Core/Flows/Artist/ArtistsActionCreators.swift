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
        guard index < state.artistsState.artists.count else { fatalError() }
        let artist = state.artistsState.artists[index]
        dispatch(AlbumsState.ActionCreators.selectArtist(artist))
      }
    }
    
    public static func selectCountry(_ country: Country) -> Thunk<AppState> {
      return Thunk<AppState> { dispatch, getState in
        dispatch(ArtistsState.Actions.loadArtists(country))
        dispatch(ArtistsState.Actions.setCountry(country))
      }
    }
  }
}
