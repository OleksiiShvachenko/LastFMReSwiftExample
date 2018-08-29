//
//  Album.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ObjectMapper

public struct TopAlbums: ImmutableMappable {
  public let albums: [Album]
  
  public init(map: Map) throws {
    albums = try map.value("topalbums.album")
  }
}

public struct Album: ImmutableMappable {
  public let name: String
  public let playcount: Int
  public let images: [Image]
  
  public init(map: Map) throws {
    name = try map.value("name")
    playcount = try map.value("playcount")
    images = try map.value("image")
  }
}
