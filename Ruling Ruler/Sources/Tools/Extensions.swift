//
//  Extensions.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

// MARK: - UIColor
extension UIColor {
    static var background: UIColor {
        return UIColor(red: 250 / 255, green: 189 / 255, blue: 14 / 255, alpha: 1.0)
    }
}

// MARK: - UIImage
extension UIImage {
    func resize(to targetSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    func flip() -> UIImage {
        return UIImage(cgImage: cgImage!, scale: 1.0, orientation: .downMirrored)
    }

    static func combined(topImage: UIImage, bottomImage: UIImage) -> UIImage {
        let size = CGSize(width: topImage.size.width, height: topImage.size.height + bottomImage.size.height)
        UIGraphicsBeginImageContext(size)

        let topImageRect = CGRect(x: 0, y: 0, width: size.width, height: topImage.size.height)
        topImage.draw(in: topImageRect)

        let bottomImageRect = CGRect(x: 0, y: topImage.size.height, width: size.width, height: bottomImage.size.height)
        bottomImage.draw(in: bottomImageRect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

// MARK: - UIDevice
extension UIDevice {
    // Model identifiers can be found at https://www.theiphonewiki.com/wiki/Models
    static let modelIdentifier: String = {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulatorModelIdentifier
        }

        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }()
}
