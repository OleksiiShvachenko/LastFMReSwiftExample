//
//  CountryArtistsState.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

public struct ArtistsState: StateType {
  public var country: Country = .ukraine
  public var artists: [Artist]?
  public var isLoading: Bool = false
  public var loadingError: Error?
}
