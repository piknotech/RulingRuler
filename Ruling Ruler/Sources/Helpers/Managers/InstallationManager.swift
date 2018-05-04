//
//  InstallationManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 17.02.18.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import Foundation

final class InstallationManager {
    // MARK: - Properties
    static let shared = InstallationManager()

    /// The version the user first installed the app with.
    var versionInstalled: String? {
        get {
            return UserDefaults.standard.string(forKey: "InstallationManager.versionInstalled")
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "InstallationManager.versionInstalled")
            UserDefaults.standard.synchronize()
        }
    }

    /// The date at which the user first installed the app.
    var dateInstalled: Date? {
        get {
            return UserDefaults.standard.object(forKey: "InstallationManager.dateInstalled") as? Date
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "InstallationManager.dateInstalled")
            UserDefaults.standard.synchronize()
        }
    }

    // MARK: - Initializers
    private init() { }

    // MARK: - Methods
    /// Takes care of storing installing data if not yet done. Should be called on launch.
    func store() {
        if dateInstalled == nil {
            dateInstalled = Date()
        }

        if versionInstalled == nil {
            versionInstalled = VersionInfo.appVersion
        }
    }
}
