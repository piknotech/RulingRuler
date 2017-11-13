//
//  InchCell.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

class InchCell: UITableViewCell {

    // MARK: - Internal properties

    var number: Int = 0 {
        didSet {
            numberLabel.text = "\(number)"
            numberLabel.isHidden = number == 0
            subviews.first { $0.tag == 1 }?.frame.origin.y = number == 0 ? Sizing.pixel : 0
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
        (0..<16).forEach {
            let width = $0 == 0 ? cellSize.width : $0 == 8 ? cellSize.width * 2 / 3 : $0 % 4 == 0 ? cellSize.width / 2 : $0 % 2 == 0 ? cellSize.width / 3 : cellSize.width / 5
            let y = (cellSize.height * CGFloat($0) / 16) - Sizing.pixel
            let view = UIView(frame: CGRect(x: cellSize.width - width, y: y, width: width, height: 2 * Sizing.pixel))
            view.tag = $0 == 0 ? 1 : 0
            view.backgroundColor = .white

            addSubview(view)
        }

        // Add number label
        numberLabel.frame = CGRect(x: -50, y: -cellSize.height/2, width: 50, height: cellSize.height)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        clipsToBounds = false
        addSubview(numberLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
