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
    case url = "#text" // try? map.value("#text", using: URL.transformString)
    case size = "size" // (try? map.value("size", using: Size.transform)) ?? .unowned
  }
}
