//
//  AppDelegate.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/12/23.
//

import SwiftUI
import BranchSDK

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Branch.setUseTestBranchKey(true)
        Branch.getInstance().enableLogging()
        Branch.getInstance().validateSDKIntegration()
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
            print(params as? [String: AnyObject] ?? {})
            // Access and use deep link data here (nav to page, display content, etc.)
        }
        
        return true
    }
    
}
