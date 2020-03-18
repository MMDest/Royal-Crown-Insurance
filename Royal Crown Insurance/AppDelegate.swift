//
//  AppDelegate.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/13/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        return UIApplication.shared.windows.first
    }()
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyDEiJ4hYUb-Iwmb0yigh_dYBiq-18qZFjQ")
        return true
    }
}
