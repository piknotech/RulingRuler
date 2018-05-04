//
//  SizeInfo.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 17.02.18.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import UIKit

struct SizeInfo {
    // MARK: - Initializers
    private init() { }

    // MARK: - Properties
    /// Returns screen's scale
    static var scale: CGFloat {
        return UIScreen.main.scale
    }

    /// Returns pixel's width / height
    static var pixel: CGFloat {
        return 1 / SizeInfo.scale
    }

    /// Determines whether screen size is 4 inch diagonally
    static var is4Inch: Bool {
        return (max(Int(UIScreen.main.bounds.height), Int(UIScreen.main.bounds.width)) == 568)
    }

    /// Determines whether user is on iPhone X
    static var isX: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2_436
    }

    /// Determines whether user is on iPad
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
