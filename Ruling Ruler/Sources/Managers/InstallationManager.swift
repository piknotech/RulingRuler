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

    // MARK: - Initializers
    private init() { }

    // MARK: - Methods
    /// Takes care of storing installing data if not yet done
    func store() {
        if InstallationInfo.dateInstalled == nil {
            InstallationInfo.dateInstalled = Date()
        }

        if InstallationInfo.versionInstalled == nil {
            InstallationInfo.versionInstalled = VersionInfo.appVersion
        }
    }
}
