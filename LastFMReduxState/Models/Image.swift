//
//  Image.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//
import Foundation

public struct Image: Decodable {
  public enum Size: String, Decodable {
    case small
    case medium
    case large
    case extralarge
    case mega
    case unowned
  }
  
  public let url: URL?
  public let size: Size
  
  enum CodingKeys : String, CodingKey {
    case url = "#text"
    case size = "size"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try? container.decodeIfPresent(URL.self, forKey: .url)
    size = try container.decode(Size.self, forKey: .size)
  }
}
