//
//  ErrorViewController.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 23.11.17.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import UIKit

final class ErrorViewController: UIViewController {
    // MARK: - Properties
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private var hintLabel = UILabel()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use launcher as base view
        let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        let launchScreenView = launchScreen.view!
        launchScreenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(launchScreenView)

        // Add hint label
        hintLabel.textColor = .white
        hintLabel.textAlignment = .center
        hintLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hintLabel.numberOfLines = 0
        hintLabel.font = .systemFont(ofSize: 400, weight: .bold)
        hintLabel.adjustsFontSizeToFitWidth = true
        hintLabel.text = "Ruling Ruler is currently not available for your device.\n😢\n\nWe'll support it in a future update.\n😁"
        view.addSubview(hintLabel)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        hintLabel.frame = view.bounds.insetBy(dx: view.bounds.width / 8, dy: view.bounds.height / 8)
    }
}
