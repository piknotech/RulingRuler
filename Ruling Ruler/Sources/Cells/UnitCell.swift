//
//  InchCell.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 12.11.17.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import UIKit

final class UnitCell: UITableViewCell {
    // MARK: - Properties
    var number: Int = 0 {
        didSet {
            var shouldAdjustForFirstCell = number == 0
            if #available(iOS 11.0, *) {
                shouldAdjustForFirstCell = shouldAdjustForFirstCell && MainViewController.shared.view.safeAreaInsets.top < 30
            }

            numberLabel.text = "\(number)"
            numberLabel.isHidden = shouldAdjustForFirstCell
            subviews.first { $0.tag == 1 }?.frame.origin.y = shouldAdjustForFirstCell ? SizeInfo.pixel : 0
        }
    }

    private var numberLabel: UILabel

    // MARK: - Initializers
    init(mode: CellMode, viewMode: CellViewMode, reuseIdentifier: String?) {
        numberLabel = UILabel()

        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        // Set background color
        backgroundColor = .clear

        // Create subviews
        let cellSize = CGSize(
            width: MainViewController.shared.cellWidth,
            height: mode == .inch ? DimensionInfo.pointsPerInch : DimensionInfo.pointsPerCentimeter
        )

        let maxIndex = mode == .inch ? 16 : 10
        (0..<maxIndex).forEach { index in
            let width: CGFloat = {
                // Centimeter
                if mode == .centimeter {
                    return index == 0 ? cellSize.width :
                        index == 5 ? cellSize.width * 2 / 3 :
                        cellSize.width / 3
                }

                // Inch
                return index == 0 ? cellSize.width :
                    index == 8 ? cellSize.width * 2 / 3 : index % 4 == 0 ? cellSize.width / 2 :
                    index % 2 == 0 ? cellSize.width / 3 : cellSize.width / 5
            }()

            let yOrigin = (cellSize.height * CGFloat(index) / CGFloat(maxIndex)) - SizeInfo.pixel
            let view = UIView(
                frame: CGRect(
                    x: viewMode == .left ? 0 : MainViewController.shared.view.bounds.width / 2 - width,
                    y: yOrigin,
                    width: width,
                    height: 2 * SizeInfo.pixel
                )
            )
            view.tag = index == 0 ? 1 : 0
            view.backgroundColor = .white

            addSubview(view)
        }

        // Add number label
        numberLabel.frame = CGRect(
            x: viewMode == .left ? cellSize.width :
                MainViewController.shared.view.bounds.width / 2 - cellSize.width - 50,
            y: -cellSize.height / 2,
            width: 50,
            height: cellSize.height
        )
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont(name: "Avenir", size: 20)
        clipsToBounds = false
        addSubview(numberLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
