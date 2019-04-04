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
  
  enum CodingKeys: String, CodingKey {
    case container = "topartists"
    case artist
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .container)
    artists = try nestedContainer.decode([Artist].self, forKey: .artist)
  }
}

public protocol Mbid {}
public typealias ArtistId = Id<String, Mbid>
public struct Artist: Decodable {
  public let name: String
  public let listeners: Int
  public let mbid: ArtistId
  public let images: [Image]
  
  enum CodingKeys : String, CodingKey {
    case name = "name"
    case listeners = "listeners"
    case mbid = "mbid"
    case images = "image"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    listeners = Int(try container.decode(String.self, forKey: .listeners))!
    mbid = ArtistId(rawValue: try container.decode(String.self, forKey: .mbid))
    images = try container.decode([Image].self, forKey: .images)
  }
}
