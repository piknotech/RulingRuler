//
//  AppDelegate.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 04.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Internal properties

    var window: UIWindow?

    // MARK: - Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Load view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        var rootVc: UIViewController = MainViewController.shared

        // Check whether dimensions loadable for device type
        guard Dimension.pixelsPerInch != nil else {
            rootVc = UIViewController() // TODO: Show error vc
            return false
        }

        // Make visible
        window!.rootViewController = rootVc
        window!.makeKeyAndVisible()

        return true
    }
}
