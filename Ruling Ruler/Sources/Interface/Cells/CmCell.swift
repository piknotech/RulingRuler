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
            numberLabel.text = "\(number)"
        }
    }

    // MARK: Private properties

    var numberLabel: UILabel

    // MARK: - Initializers

    init(cellSize: CGSize, reuseIdentifier: String?) {
        numberLabel = UILabel()

        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        // Set background color
        backgroundColor = .clear

        // Create subviews
        (0..<10).forEach {
            let width = $0 == 0 ? cellSize.width : $0 == 5 ? cellSize.width * 2 / 3 : cellSize.width / 3
            let y = (cellSize.height * CGFloat($0) / 10) - Sizing.pixel
            let view = UIView(frame: CGRect(x: 0, y: y, width: width, height: 2 * Sizing.pixel))
            view.backgroundColor = .white

            addSubview(view)
        }

        // Add number label
        numberLabel.frame = CGRect(x: cellSize.width, y: 0, width: 30, height: cellSize.height)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        clipsToBounds = false
        addSubview(numberLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
