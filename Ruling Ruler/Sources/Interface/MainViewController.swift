//
//  ViewController.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 04.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Internal properties

    static let shared = MainViewController()

    lazy var cmCount: Int = { 254 * countMultiplier }()
    lazy var inchCount: Int = { 100 * countMultiplier }()
    var tableViewWidth: CGFloat = 50

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Private properties

    private var scrollView = UIScrollView()
    private var cmTableView = UITableView()
    private var inchTableView = UITableView()
    private var cmTableViewManager = CmTableViewManager()
    private var inchTableViewManager = InchTableViewManager()
    private let countMultiplier = 4

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure table views
        cmTableView.isScrollEnabled = false
        cmTableView.isUserInteractionEnabled = false
        cmTableView.separatorStyle = .none
        cmTableView.backgroundColor = .clear
        cmTableView.clipsToBounds = false
        cmTableView.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: CGFloat(cmCount) * Dimension.pointsPerCentimeter)
        inchTableView.isScrollEnabled = false
        inchTableView.isUserInteractionEnabled = false
        inchTableView.separatorStyle = .none
        inchTableView.backgroundColor = .clear
        inchTableView.clipsToBounds = false
        inchTableView.frame = CGRect(x: view.bounds.size.width - tableViewWidth, y: 0, width: tableViewWidth, height: CGFloat(inchCount) * Dimension.pointsPerInch)

        // Configure table view managers
        cmTableView.dataSource = cmTableViewManager
        cmTableView.delegate = cmTableViewManager
        inchTableView.dataSource = inchTableViewManager
        inchTableView.delegate = inchTableViewManager

        // Configure scroll view
        scrollView.frame = view.bounds
        scrollView.backgroundColor = .background
        scrollView.decelerationRate = 0.01
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize.height = cmTableView.bounds.size.height

        // Create app icon image view
        let appIconImageView = UIImageView(image: UIImage(named: "app_icon"))
        appIconImageView.frame.size = CGSize(width: 80, height: 80)
        appIconImageView.center = CGPoint(x: scrollView.center.x, y: 150)
        appIconImageView.layer.cornerRadius = appIconImageView.bounds.size.width * 0.2237
        appIconImageView.layer.masksToBounds = true

        // Add views
        scrollView.addSubview(cmTableView)
        scrollView.addSubview(inchTableView)
        scrollView.addSubview(appIconImageView)
        view.addSubview(scrollView)
    }
}
