//
//  ArtistState.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

public struct AlbumsState: StateType {
  public var artist: Artist?
  public var albums: [Album] = []
}
