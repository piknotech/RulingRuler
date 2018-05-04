//
//  ScreenshotManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 15.04.18.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import UIKit

final class ScreenshotManager {
    // MARK: - Subtypes
    struct Configuration {
        var cmIsLeft: Bool
        var topCm: CGFloat
    }

    // MARK: - Properties
    static let shared = ScreenshotManager()
    private let configurations: [Configuration] = [
        Configuration(cmIsLeft: true, topCm: 0),
        Configuration(cmIsLeft: false, topCm: 0),
        Configuration(cmIsLeft: true, topCm: 93.43)
    ]
    private var currentConfigIndex = 0
    private var cmIsLeftCurrently = true

    // MARK: - Methods
    /// Main start point. To be called in AppDelegate.
    func takeover() {
        let mainVc = MainViewController.shared

        // Create overlay view and add gesture recognizer.
        // This automatically disables other user interaction
        let view = UIView(frame: mainVc.view.bounds)
        view.backgroundColor = UIColor.white.withAlphaComponent(0) // Required for tap gesture recognizer
        UIApplication.shared.delegate!.window!!.addSubview(view)

        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(screenTapped(sender:))
        )
        view.addGestureRecognizer(recognizer)

        // Setup for first configuration
        setup(for: configurations.first!)
    }

    // MARK: Top Handling
    /// Navigates between screenshots when the screen is tapped.
    @objc
    private func screenTapped(sender: UITapGestureRecognizer) {
        let isOnLeftHalf = sender.location(in: MainViewController.shared.view).x < MainViewController.shared.view.bounds.width / 2

        if isOnLeftHalf {
            currentConfigIndex = max(currentConfigIndex - 1, 0)
        } else {
            currentConfigIndex = min(currentConfigIndex + 1, configurations.count - 1)
        }

        // Setup for next configuration
        setup(for: configurations[currentConfigIndex])
    }

    /// Sets up the view for the given configuration.
    private func setup(for configuration: Configuration) {
        let mainVc = MainViewController.shared

        // Manage scroll position
        // Only when animating, all other cells on the path to the needed cell are calculated.
        // If not animated, other cells are too small & thereby position is inaccurate
        mainVc.scrollTableViews(
            to: configuration.topCm * DimensionInfo.pointsPerCentimeter,
            animated: true
        )

        // Manage sides
        if cmIsLeftCurrently && !configuration.cmIsLeft {
            mainVc.switchSides()
            cmIsLeftCurrently = false
        } else if !cmIsLeftCurrently && configuration.cmIsLeft {
            mainVc.switchSides()
            cmIsLeftCurrently = true
        }
    }
}
