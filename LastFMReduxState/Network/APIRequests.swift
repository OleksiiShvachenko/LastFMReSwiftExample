//
//  APIManagerRequests.swift
//
//  Created by Yevhen Herasymenko.
//  Copyright © 2017 Stratege. All rights reserved.
//

import Alamofire

public enum ResponseHeader {
  
  private struct Key {
    static let token = "AuthenticateToken"
  }
  
  case token
  case noHeader
  
  public func parse(header: [AnyHashable: Any]) {
    switch self {
    case .token:
      guard let token = header[Key.token] as? String else { return }
      print(token)
    case .noHeader: break
    }
  }
}

final class API {
  
  static private let apiKey = "22fe3534d6700d93d59550970657a18d"
  
  private struct Path {
    static let base = "http://ws-audioscrobbler-com-szrg8j2mf6sp.runscope.net/2.0"
  }
  
  static func topArtists(for country: String) -> Request<TopArtists> {
    let url = Path.base
    let parameters = ["method": "geo.gettopartists",
                      "country": country,
                      "api_key": API.apiKey,
                      "format": "json"]
    return Request<TopArtists>(url: url, parameters: parameters)
  }
  
  static func topAlbums(for artistMbid: String) -> Request<TopAlbums> {
    let url = Path.base
    let parameters = ["method": "artist.gettopalbums",
                      "mbid": artistMbid,
                      "api_key": API.apiKey,
                      "format": "json"]
    return Request<TopAlbums>(url: url, parameters: parameters)
  }
  
}
