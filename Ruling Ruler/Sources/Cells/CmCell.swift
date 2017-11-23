//
//  CmCell.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

class CmCell: UITableViewCell {
    // MARK: - Internal properties
    var number: Int = 0 {
        didSet {
            var shouldAdjustForFirstCell = number == 0
            if #available(iOS 11.0, *) {
                shouldAdjustForFirstCell = shouldAdjustForFirstCell && MainViewController.shared.view.safeAreaInsets.top < 30
            }

            numberLabel.text = "\(number)"
            numberLabel.isHidden = shouldAdjustForFirstCell
            subviews.first { $0.tag == 1 }?.frame.origin.y = shouldAdjustForFirstCell ? Sizing.pixel : 0
        }
    }

    // MARK: Private properties
    var numberLabel: UILabel

    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        numberLabel = UILabel()

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Set background color
        backgroundColor = .clear

        // Create subviews
        let cellSize = CGSize(width: MainViewController.shared.tableViewWidth, height: Dimension.pointsPerCentimeter)
        (0..<10).forEach {
            let width = $0 == 0 ? cellSize.width : $0 == 5 ? cellSize.width * 2 / 3 : cellSize.width / 3
            let y = (cellSize.height * CGFloat($0) / 10) - Sizing.pixel
            let view = UIView(frame: CGRect(x: 0, y: y, width: width, height: 2 * Sizing.pixel))
            view.tag = $0 == 0 ? 1 : 0
            view.backgroundColor = .white

            addSubview(view)
        }

        // Add number label
        numberLabel.frame = CGRect(x: cellSize.width, y: -cellSize.height/2, width: 50, height: cellSize.height)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        clipsToBounds = false
        addSubview(numberLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
