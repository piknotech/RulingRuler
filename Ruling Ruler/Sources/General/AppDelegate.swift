//
//  AppDelegate.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 04.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Internal properties
    var window: UIWindow?

    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Setup Fabric
        Fabric.with([Crashlytics.self, Answers.self])

        // Load view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        var rootVc: UIViewController = MainViewController.shared

        // Check whether dimensions loadable for device type
        if Dimension.pixelsPerInch != nil {
            // Set error vc as root vc
            rootVc = ErrorViewController()
        }

        // Make visible
        window!.rootViewController = rootVc
        window!.makeKeyAndVisible()

        return true
    }
}
