//
//  Country.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation

public enum Country: String {
  case ukraine
  case spain
  case israel
  case brazil
  case france
  
  public static let all: [Country] = [.ukraine, .spain, .israel, .brazil, .france]
}
