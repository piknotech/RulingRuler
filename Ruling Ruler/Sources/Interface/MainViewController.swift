//
//  ViewController.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 04.11.17.
//  Copyright © 2017 Frederick Pietschmann. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
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

        // Use launcher as base view
        let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        let launchScreenView = launchScreen.view!
        launchScreenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(launchScreenView)

        // Configure table views
        cmTableView.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: view.bounds.size.height)
        inchTableView.frame = CGRect(x: view.bounds.size.width - tableViewWidth, y: 0, width: tableViewWidth, height: view.bounds.size.height)
        [cmTableView, inchTableView].forEach { tableView in
            tableView.isUserInteractionEnabled = false
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            tableView.clipsToBounds = false
        }

        // Configure table view managers
        cmTableView.dataSource = cmTableViewManager
        cmTableView.delegate = cmTableViewManager
        inchTableView.dataSource = inchTableViewManager
        inchTableView.delegate = inchTableViewManager

        // Configure scroll view
        scrollView.frame = view.bounds
        scrollView.backgroundColor = .clear
        scrollView.decelerationRate = 0.01
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize.height = CGFloat(cmCount) * Dimension.pointsPerCentimeter

        // Create app icon image view
        let appIconImageView = UIImageView(image: UIImage(named: "app_icon"))
        appIconImageView.frame.size = CGSize(width: 80, height: 80)
        appIconImageView.center = CGPoint(x: scrollView.center.x, y: 150)
        appIconImageView.layer.cornerRadius = appIconImageView.bounds.size.width * 0.2237
        appIconImageView.layer.masksToBounds = true

        // Add views
        scrollView.addSubview(appIconImageView)
        view.addSubview(scrollView)
        view.addSubview(cmTableView)
        view.addSubview(inchTableView)
    }

    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Set new content offset also to table views
        scrollView.contentOffset.y = scrollView.contentOffset.y
        cmTableView.contentOffset.y = scrollView.contentOffset.y
        inchTableView.contentOffset.y = scrollView.contentOffset.y
    }
}
