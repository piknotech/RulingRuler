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
        if let cmCell = tableView.dequeueReusableCell(withIdentifier: "InchCell") {
            return cmCell
        }

        let cmCell = InchCell(cellSize: CGSize(width: tableView.frame.size.width, height: Dimension.pointsPerInch), reuseIdentifier: "InchCell")
        return cmCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cmCell = cell as? InchCell {
            cmCell.number = indexPath.row
        }
    }
}
