//
//  Classes.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

// MARK: - Threading

/// Class simplifying the way to perform blocks in background or in main thread
class Threading {
    /// Enum representation of the two dispatch types
    enum ThreadType {
        case main
        case background
    }

    /// Performs a given block in a given thread and a completion block in the main thread
    class func perform(in thread: Threading.ThreadType, block: @escaping () -> Void, completion: (() -> Void)? = nil) {
        switch thread {
        case .background:
            DispatchQueue.global(qos: .background).async {
                block()
                if let completion = completion {
                    perform(in: .main, block: completion)
                }
            }
        case .main:
            DispatchQueue.main.async {
                block()
                completion?()
            }
        }
    }

    /// Wrapper to enable trailing closure
    class func perform(in thread: Threading.ThreadType, block: @escaping () -> Void) {
        perform(in: thread, block: block, completion: nil)
    }
}

// MARK: - Timing

/// Class simplifying the process of executing code after a delay
class Timing: NSObject {
    /// Performs a given block after a specific delay in a given thread
    class func perform(after delay: TimeInterval, in thread: Threading.ThreadType, block: @escaping () -> Void) {
        let timer = Timer(timeInterval: delay, target: self, selector: #selector(Timing.fire(timer:)), userInfo: ["block": block, "thread": thread], repeats: false)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }

    @objc class func fire(timer: Timer) {
        Threading.perform(in: ((timer.userInfo as! [String: AnyObject])["thread"] as! Threading.ThreadType), block: (timer.userInfo as! [String: AnyObject])["block"] as! () -> Void)
    }
}

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
