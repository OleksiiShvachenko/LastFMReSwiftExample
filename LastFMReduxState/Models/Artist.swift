//
//  Artist.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//
import Foundation

public struct TopArtists: Decodable {
  public let artists: [Artist]
  
  enum CodingKeys : String, CodingKey {
    case artists = "topartists.artist"
  }
}

public struct Artist: Decodable {
  public let name: String
  public let listeners: Int
  public let mbid: String
  public let images: [Image]
  
  enum CodingKeys : String, CodingKey {
    case name = "name"
    case listeners = "listeners" //try map.value("listeners", using: String.transformInt)
    case mbid = "mbid"
    case images = "image"
  }
}
