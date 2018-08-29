//
//  Transforms.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ObjectMapper

extension URL {
  static var transformString: TransformOf<URL, String> {
    return TransformOf<URL, String>(fromJSON: { (value: String?) -> URL? in
      guard let value = value else { return nil }
      return URL(string: value)
    }, toJSON: { (value: URL?) -> String? in
      guard let value = value else { return nil }
      return value.absoluteString
    })
  }
  
}

extension String {
  static var transformInt: TransformOf<Int, String> {
    return TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
      guard let value = value else { return nil }
      return Int(value)
    }, toJSON: { (value: Int?) -> String? in
      guard let value = value else { return nil }
      return "\(value)"
    })
  }
}

extension Image.Size {
  
  static var transform: TransformOf<Image.Size, String> {
    return TransformOf<Image.Size, String>(fromJSON: { (value: String?) -> Image.Size? in
      guard let value = value else { return nil }
      return Image.Size(rawValue: value)
    }, toJSON: { (value: Image.Size?) -> String? in
      guard let value = value else { return nil }
      return value.rawValue
    })
  }
  
}
