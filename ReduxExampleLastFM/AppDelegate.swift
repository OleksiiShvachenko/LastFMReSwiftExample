//
//  AppDelegate.swift
//  ReduxExampleLastFM
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit
import LastFMReduxState
import ReSwift

var mainStore: Store<AppState>! {
  return (UIApplication.shared.delegate as? AppDelegate)?.store
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private(set) var store: Store<AppState>!
  private var sessionManager: APIManager!
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    sessionManager = APIManager()
    store = createStore(sessionManager)
    return true
  }
  
}
