//
//  SizeInfo.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 17.02.18.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import UIKit

struct SizeInfo {
    // MARK: - Properties
    /// Returns screen's scale
    static var scale: CGFloat {
        return UIScreen.main.scale
    }

    /// Returns pixel's width / height
    static var pixel: CGFloat {
        return 1 / SizeInfo.scale
    }

    // MARK: - Initializers
    private init() { }
}
