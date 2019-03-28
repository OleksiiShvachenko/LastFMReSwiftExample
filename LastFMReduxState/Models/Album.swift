//
//  Album.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation

public struct TopAlbums: Decodable {
  public let albums: [Album]
  
  enum CodingKeys : String, CodingKey {
    case albums = "topalbums.album"
  }
}

public struct Album: Decodable {
  public let name: String
  public let playcount: Int
  public let images: [Image]
  
  enum CodingKeys : String, CodingKey {
    case name = "name"
    case playcount = "playcount"
    case images = "image"
  }
}
