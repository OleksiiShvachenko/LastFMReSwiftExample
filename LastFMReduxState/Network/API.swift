//
//  API.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/6/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation

public protocol API {
  func topArtists(for country: String, callback: @escaping ((_ result: Swift.Result<TopArtists, NetworkError>) -> Void))
  func topAlbums(for artistMbid: String, callback: @escaping ((_ result: Swift.Result<TopAlbums, NetworkError>) -> Void))
  func cancel()
}
