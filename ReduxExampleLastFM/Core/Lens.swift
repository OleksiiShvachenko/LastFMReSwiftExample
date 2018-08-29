//
//  Lens.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/2/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation
import LastFMReduxState

protocol Lens {
    associatedtype ResultState
    static func lens(_ state: AppState) -> ResultState
    static func filter(old: ResultState, new: ResultState) -> Bool
}

extension Lens {
    static func filter(old: ResultState, new: ResultState) -> Bool {
        return true
    }
}
