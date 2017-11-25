//
//  ScrollManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 25.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

class ScrollManager: NSObject, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        MainViewController.shared.tableViews.filter { $0 != scrollView }.forEach {
            $0.contentOffset.y = scrollView.contentOffset.y
        }
    }
}
