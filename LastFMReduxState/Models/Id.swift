//
//  Id.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 4/4/19.
//  Copyright © 2019 Ciklum. All rights reserved.
//

import Foundation

public struct Id<Value, Tag>: RawRepresentable {
  public init(rawValue: Value) {
    self.rawValue = rawValue
  }
  public var rawValue: Value
}
