//
//  APIManager.swift
//
//  Created by Yevhen Herasymenko.
//  Copyright © 2017 Yevhen Herasymenko. All rights reserved.
//

import Foundation
import LastFMReduxState
import Alamofire

final class APIManager: API {
  
  func topArtists(for country: String, callback: @escaping ((Swift.Result<TopArtists, Error>) -> Void)) {
    let params = [
      "method": "geo.gettopartists",
      "api_key": "22fe3534d6700d93d59550970657a18d",
      "format":
      "json", "country": country
    ]
    AF.request("https://ws.audioscrobbler.com/2.0", method: .get, parameters: params).responseDecodable { (response: DataResponse<TopArtists>) in
      switch response.result {
      case .success(let artist):
        callback(Swift.Result.success(artist))
      case .failure(let error):
        callback(Swift.Result.failure(self.handleError(error)))
      }
    }
  }
  
  func topAlbums(for artistMbid: String, callback: @escaping ((Swift.Result<TopAlbums, Error>) -> Void)) {
    let params = [
      "method": "artist.gettopalbums",
      "api_key": "22fe3534d6700d93d59550970657a18d",
      "format": "json",
      "mbid": artistMbid
    ]
    AF.request("https://ws.audioscrobbler.com/2.0", method: .get, parameters: params).responseDecodable { (response: DataResponse<TopAlbums>) in
      switch response.result {
      case .success(let albums):
        callback(Swift.Result.success(albums))
      case .failure(let error):
        callback(Swift.Result.failure(error))
      }
    }
  }
  
  func cancel() {
  }
  
  private func handleError(_ error: Error) -> NetworkError {
    return .parsingError("Test")
  }
}
