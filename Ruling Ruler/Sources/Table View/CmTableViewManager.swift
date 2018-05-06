//
//  CmTableViewManager.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import UIKit

final class CmTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties
    static let shared = CmTableViewManager()

    // MARK: - Initializers
    private override init() { }

    // MARK: - Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.shared.cmCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cmCell = tableView.dequeueReusableCell(withIdentifier: "CmCell") {
            return cmCell
        }

        let cmCell = UnitCell(mode: .centimeter, viewMode: tableView.frame.origin.x == 0 ? .left : .right, reuseIdentifier: "CmCell")
        return cmCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cmCell = cell as? UnitCell {
            cmCell.number = indexPath.row
        }
    }
}
