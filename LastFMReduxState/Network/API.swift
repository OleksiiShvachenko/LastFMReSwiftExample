//
//  API.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/6/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

/**
 Result for API request
 
 - Failure: error
 - Success: result which was mapped into some model object/objects
 */
import Foundation

//public enum Result<T> {
//  case failure(NetworkError)
//  case success(T)
//}

public protocol API {
  func topArtists(for country: String, callback: @escaping ((_ result: Result<TopArtists, NetworkError>) -> Void))
  func topAlbums(for artistMbid: String, callback: @escaping ((_ result: Result<TopAlbums, NetworkError>) -> Void))
  func cancel()
}
