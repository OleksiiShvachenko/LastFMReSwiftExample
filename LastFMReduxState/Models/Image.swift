//
//  Image.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ObjectMapper

public struct Image: ImmutableMappable {
  public enum Size: String {
    case small
    case medium
    case large
    case extralarge
    case mega
    case unowned
  }
  
  public let url: URL?
  public let size: Size
  
  public init(map: Map) throws {
    url = try? map.value("#text", using: URL.transformString)
    size = (try? map.value("size", using: Size.transform)) ?? .unowned
  }
}
