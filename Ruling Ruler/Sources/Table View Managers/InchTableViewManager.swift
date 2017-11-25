//
//  InchTableViewManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

class InchTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.shared.inchCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimension.pointsPerInch
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let inchCell = tableView.dequeueReusableCell(withIdentifier: "InchCell") {
            return inchCell
        }
        
        let inchCell = InchCell(style: .default, reuseIdentifier: "InchCell")
        return inchCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let inchCell = cell as? InchCell {
            inchCell.number = indexPath.row
        }
    }
}
