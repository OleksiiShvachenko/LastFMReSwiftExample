//
//  CountryArtistsState.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift
import ReSwiftThunk

public struct CountryArtistsState: StateType {
  public var artists: [Artist]
  public var country: Country
}

extension CountryArtistsState {
  struct Reducer {
    static func handleAction(action: ReSwift.Action, state: CountryArtistsState?) -> CountryArtistsState {
      var state = state ?? CountryArtistsState(artists: [], country: .ukraine)
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
  
  public enum ActionCreators {
    
    public static func didTapOnArtist(at index: Int) -> Thunk<AppState> {
      return Thunk<AppState> { dispatch, getState in
        guard let state = getState() else { return }
        guard index < state.artistsByCountryState.artists.count else { fatalError() }
        let artist = state.artistsByCountryState.artists[index]
        dispatch(ArtistState.ActionCreators.selectArtist(artist))
      }
    }
    
    public static func selectCountry(_ country: Country) -> Thunk<AppState> {
      return Thunk<AppState> { dispatch, getState in
        dispatch(Actions.loadArtists(country))
        dispatch(Actions.setCountry(country))
      }
    }
  }
}
