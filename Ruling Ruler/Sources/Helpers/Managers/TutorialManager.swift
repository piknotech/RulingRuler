//
//  TutorialManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 04.05.18.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import UIKit

final class TutorialManager {
    // MARK: - Properties
    static let shared = TutorialManager()
    private var tutorialSeen: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "TutorialManager.tutorialSeen")
        }

        set {
            UserDefaults.standard.set(newValue, forKey: "TutorialManager.tutorialSeen")
            UserDefaults.standard.synchronize()
        }
    }

    // MARK: - Initializers
    private init() { }

    // MARK: - Methods
    /// Shows an alert with some basic tips. Returns Bool whether tutorial was needed.
    @discardableResult
    func showTutorialIfNeeded(on hostVc: MainViewController) -> Bool {
        if !tutorialSeen {
            let alertVc = UIAlertController(
                title: "Welcome!",
                message: "This ruler is most simple:\n\n• Centimeters & inches\n• Tap to switch sides\n• Scroll for long distances\n\nThat's it!",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "Easy!", style: .default)
            alertVc.addAction(okAction)
            hostVc.present(alertVc, animated: true) { [unowned self] in
                self.tutorialSeen = true
            }

            return true
        }

        return false
    }
}
