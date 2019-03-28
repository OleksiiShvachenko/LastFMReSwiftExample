//
//  ParseOperation.swift
//  Zerto_iOS
//
//  Created by Yevhen Herasymenko on 5/20/16.
//  Copyright © 2016 Yevhen Herasymenko. All rights reserved.
//

import Foundation
import LastFMReduxState

struct JSONKey {
    static let errorCode = "ErrorCode"
    static let errorMessage = "ErrorMessage"
    static let result = "Result"
}

class ParseOperation<T: Decodable>: BasicOperation {
    
    var error: NetworkError?
    
    override func operation() {
        parse()
        finish()
    }
    
    func parse() { }
    
}
//
//class ParseObjectOperation<T: Decodable>: ParseOperation<T> {
//    var jsonData: Data?
//    var result: T?
//    
//    override func parse() {
//        guard let jsonData = jsonData else {
//            error = .wrongFormat("Empty dictionary for parsing!")
//            return
//        }
//        do {
//            let value = try JSONDecoder().decode(T.self, from: jsonData)
//            result = value
//        } catch let error as Error {
//            self.error = .parsingError(error.description)
//        } catch {
//            fatalError("Can't parse model")
//        }
//    }
//}
//
//class ParseArrayOperation<T: Decodable>: ParseOperation<T> {
//    
//    var dictionaries: [[String: AnyObject]]?
//    var results: [T]?
//    
//    override func parse() {
//        guard let dictionaries = dictionaries else {
//            error = .wrongFormat("No dictionaries for parsing!")
//            return
//        }
//        do {
//            let value = try Mapper<T>().mapArray(JSONArray: dictionaries)
//            results = value
//        } catch let error as MapError {
//            self.error = .parsingError(error.description)
//            self.error = .unknown(error.localizedDescription)
//        } catch {
//            fatalError("Can't parse model")
//        }
//    }
//    
//}
