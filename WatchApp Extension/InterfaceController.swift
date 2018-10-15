//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Frederick Pietschmann on 14.10.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    // MARK: - Subtypes
    private enum WatchType: String {
        case watch44
        case watch42
        case watch40
        case watch38
    }

    private enum OrientationType: String {
        case cmInch
        case inchCm
    }

    // MARK: - Properties
    private var currentOrientation: OrientationType = .cmInch
    private lazy var watchType: WatchType? = {
        // TODO
        print(WKInterfaceDevice.current().model)
        switch WKInterfaceDevice.current().model {
        case "qwer":
            return .watch44

        case "fgh":
            return .watch42

        case "dfg":
            return .watch40

        case "sdf":
            return .watch38

        default:
            return nil
        }
    }()

    @IBOutlet private var errorLabel: WKInterfaceLabel!
    @IBOutlet private var mainImageView: WKInterfaceImage!

    // MARK: - Methods
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        updateUI()
    }

    @IBAction func switchSidesButtonPressed() {
        currentOrientation = currentOrientation == .cmInch ? .inchCm: .cmInch
        updateUI()
    }

    private func updateUI() {
        guard let watchType = watchType else {
            mainImageView.setHidden(true)
            errorLabel.setHidden(false)
            return
        }

        let appropriateImage = image(forType: watchType, orientation: currentOrientation)
        mainImageView.setImage(appropriateImage)

        mainImageView.setHidden(false)
        errorLabel.setHidden(true)
    }

    private func image(forType watchType: WatchType, orientation orientationType: OrientationType) -> UIImage {
        let imageName = "\(watchType)-\(orientationType)"
        guard let image = UIImage(named: "\(watchType)-\(orientationType)") else {
            fatalError("Unable to get image named \(imageName)")
        }

        return image
    }
}
