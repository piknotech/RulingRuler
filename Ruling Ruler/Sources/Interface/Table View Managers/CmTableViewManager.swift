//
//  CmTableViewManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

class CmTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.shared.cmCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimension.pointsPerCentimeter
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cmCell = tableView.dequeueReusableCell(withIdentifier: "CmCell") {
            return cmCell
        }

        let cmCell = CmCell(style: .default, reuseIdentifier: "CmCell")
        tableView.register(CmCell.self, forCellReuseIdentifier: "CmCell")
        return cmCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cmCell = cell as? CmCell {
            cmCell.number = indexPath.row
        }
    }
}
