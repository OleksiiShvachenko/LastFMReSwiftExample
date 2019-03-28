//
//  NetworkError.swift
//
//  Created by YevhenHerasymenko.
//  Copyright © 2017 Yevhen Herasymenko. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
  
  public struct ServerError: Decodable {
    let message: String?
    
    enum CodingKeys : String, CodingKey {
      case message = "Message"
    }
  }
  
  private struct StatusCode {
    static let generalRequest = 400
    static let unauthorize = 401
    static let noPermissions = 403
    static let notFound = 404
    static let wrongMethod = 405
    static let timeout = 408
    static let internalServerMin = 500
    static let internalServerMax = 599
  }
  
  case noInternetConnection(String?)
  case generalRequest(String?)
  case unauthorize(String?)
  case noPermissions(String?)
  case notFound(String?)
  case wrongMethod(String?)
  case timeout(String?)
  case internalServer(String?)
  case wrongFormat(String?)
  case parsingError(String?)
  case unknown(String?)
  
  public init(statusCode: Int, errorData: Data? = nil) {
    let message: String?
    if let errorData = errorData {
      let serverError: ServerError? = try? JSONDecoder().decode(ServerError.self, from: errorData)
      message = serverError?.message
    } else {
      message = nil
    }
    
    switch statusCode {
    case StatusCode.generalRequest: self = .generalRequest(message)
    case StatusCode.unauthorize: self = .unauthorize(message)
    case StatusCode.noPermissions: self = .noPermissions(message)
    case StatusCode.notFound: self = .notFound(message)
    case StatusCode.wrongMethod: self = .wrongMethod(message)
    case StatusCode.timeout: self = .timeout(message)
    case let code where code >= StatusCode.internalServerMin && code <= StatusCode.internalServerMax:
      self = .internalServer(message)
    default:
      self = .unknown("Unowned status code!")
    }
  }
  
  var stringValue: String {
    switch self {
    case .generalRequest(let value),
         .noInternetConnection(let value),
         .unauthorize(let value),
         .noPermissions(let value),
         .notFound(let value),
         .wrongMethod(let value),
         .wrongFormat(let value),
         .timeout(let value),
         .internalServer(let value),
         .parsingError(let value),
         .unknown(let value):
      return value ?? self.localizedDescription
    }
  }
}
