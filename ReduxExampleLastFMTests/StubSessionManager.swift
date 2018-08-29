//
//  StubSessionManager.swift
//  ReduxExampleLastFMTests
//
//  Created by Oleksii Shvachenko on 8/29/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import ObjectMapper
import Alamofire
import XCTest
@testable import LastFMReduxState

enum StubResult {
  case succes(filename: String)
  case error(NetworkError)
}

class Stub {
  let result: StubResult
  let url: URLConvertible
  let method: Alamofire.HTTPMethod
  
  init(result: StubResult, url: URLConvertible, method: Alamofire.HTTPMethod) {
    self.result = result
    self.url = url
    self.method = method
  }
  
  func initStubObject<T: ImmutableMappable>() -> LastFMReduxState.Result<T> {
    switch result {
    case .error(let error):
      return LastFMReduxState.Result<T>.failure(error)
    case .succes(let filename):
      let json = loadObject(filename)
      let object = try! Mapper<T>().map(JSON: json)
      return LastFMReduxState.Result<T>.success(object)
    }
  }
  
  func initStubArray<T: ImmutableMappable>() -> LastFMReduxState.Result<[T]> {
    switch result {
    case .error(let error):
      return LastFMReduxState.Result<[T]>.failure(error)
    case .succes(let filename):
      let jsonArray = loadObjectArray(filename)
      let objects = try! Mapper<T>().mapArray(JSONArray: jsonArray)
      return LastFMReduxState.Result<[T]>.success(objects)
    }
  }
  
  private func loadObject(_ filename: String) -> [String: AnyObject] {
    guard let dataURL = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json"),
      let data = try? Data(contentsOf: dataURL) else {
        XCTFail("can't load data from file: \(filename)")
        return [:]
    }
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
      let dict = json as? [String: AnyObject] else {
        XCTFail("can't parse json from file: \(filename)")
        return [:]
    }
    return dict
  }
  
  private func loadObjectArray(_ filename: String) -> [[String: AnyObject]] {
    guard let dataURL = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json"),
      let data = try? Data(contentsOf: dataURL) else {
        XCTFail("can't load data from file: \(filename)")
        return []
    }
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
      let dict = json as? [[String: AnyObject]] else {
        XCTFail("can't parse json from file: \(filename)")
        return []
    }
    return dict
  }
}

class StubSessionManager: APIConformable {
  
  let stubs: [Stub]
  
  init(_ stubs: [Stub]) {
    self.stubs = stubs
  }
  
  func objectRequest<T: ImmutableMappable>(_ request: LastFMReduxState.Request<T>,
                                           callback: @escaping ((_ result: LastFMReduxState.Result<T>) -> Void)) {
    if let stub = stubs.first(where: { try! $0.url.asURL() == request.url.asURL() && $0.method == request.method }) {
      callback(stub.initStubObject())
    }
  }
  
  func arrayRequest<T: ImmutableMappable>(_ request: LastFMReduxState.Request<T>,
                                          callback: @escaping ((_ result: LastFMReduxState.Result<[T]>) -> Void)) {
    if let stub = stubs.first(where: { try! $0.url.asURL() == request.url.asURL() && $0.method == request.method }) {
      callback(stub.initStubArray())
    }
  }
  
  func cancel() {}
}
