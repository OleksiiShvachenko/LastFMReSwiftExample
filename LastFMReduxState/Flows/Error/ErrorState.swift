//
//  ErrorState.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/2/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

public struct ErrorState: StateType {
  public var generalErrorMessage: String?
}

extension ErrorState {
  struct Reducer {
    static func handleAction(action: Action, state: ErrorState?) -> ErrorState {
      var state = state ?? ErrorState(generalErrorMessage: nil)
      switch action {
      case Actions.errorMessage(let error):
        state.generalErrorMessage = error
      default:
        state.generalErrorMessage = nil
      }
      return state
    }
  }
  
  enum Actions: Action {
    case errorMessage(String)
  }
}
