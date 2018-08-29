//
//  Artist.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ObjectMapper

public struct TopArtists: ImmutableMappable {
  public let artists: [Artist]
  
  public init(map: Map) throws {
    artists = try map.value("topartists.artist")
  }
}

public struct Artist: ImmutableMappable {
  public let name: String
  public let listeners: Int
  public let mbid: String
  public let images: [Image]
  
  public init(map: Map) throws {
    name = try map.value("name")
    listeners = try map.value("listeners", using: String.transformInt)
    mbid = try map.value("mbid")
    images = try map.value("image")
  }
}
