//
//  NetworkActions.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 8/28/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import ReSwift

enum NetworkActions: Action {
  case loadArtists(country: String)
  case loadAlbums(artistMbid: String)
  case loadAlbumFullInfo(album: String, artist: String)
}
