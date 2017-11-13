//
//  Classes.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

// MARK: - Sizing

/// Class providing data on screen sizing
class Sizing {
    /// Returns screen's scale
    static var scale: CGFloat {
        return UIScreen.main.scale
    }

    /// Returns pixel's width / height
    static var pixel: CGFloat {
        return 1 / Sizing.scale
    }
}
