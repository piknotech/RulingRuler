//
//  CmTableViewManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

class CmTableViewManager: ScrollManager, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.shared.cmCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cmCell = tableView.dequeueReusableCell(withIdentifier: "CmCell") {
            return cmCell
        }

        let cmCell = UnitCell(mode: .cm, viewMode: tableView.frame.origin.x == 0 ? .left : .right, reuseIdentifier: "CmCell")
        return cmCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cmCell = cell as? UnitCell {
            cmCell.number = indexPath.row
        }
    }
}
