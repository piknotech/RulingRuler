//
//  AppReviewManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 07.01.18.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import Foundation
import StoreKit

final class AppReviewManager {
    // MARK: - Properties
    static let shared = AppReviewManager()

    private let minDays = 5
    private let minDaysInterval = 15
    private let minEventsInterval = 5

    private var events: Int {
        get {
            return UserDefaults.standard.integer(forKey: "AppReviewManager.events")
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "AppReviewManager.events")
        }
    }

    private var lastAskDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: "AppReviewManager.lastAskDate") as? Date
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "AppReviewManager.lastAskDate")
        }
    }

    // MARK: - Initializers
    private init() { }

    // MARK: - Methods
    func request() {
        if shouldTrigger() {
            SKStoreReviewController.requestReview()
            lastAskDate = Date()
            events = 0
        } else {
            events += 1
        }
    }

    /// Returns a Bool whether request to StoreKit should be done based on current event count + 1
    func shouldTrigger() -> Bool {
        // Event interval check
        guard events + 1 >= minEventsInterval else { return false }

        // Minimum usage check
        let day = 86_400
        if let installationDate = InstallationInfo.dateInstalled {
            guard Date().timeIntervalSince(installationDate) >= Double(minDays * day) else { return false }
        }

        // Minimum interval check
        if let lastAskDate = lastAskDate {
            guard Date().timeIntervalSince(lastAskDate) < Double(minDaysInterval * day) else { return false }
        }

        return true
    }
}
