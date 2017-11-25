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
    private var cmTableView1 = UITableView()
    private var cmTableView2 = UITableView()
    private var inchTableView1 = UITableView()
    private var inchTableView2 = UITableView()
    private var cmTableViewManager = CmTableViewManager()
    private var inchTableViewManager = InchTableViewManager()
    private let countMultiplier = 1

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get launcher view
        let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        let launchScreenView = launchScreen.view!
        launchScreenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Create app icon image view
        let appIconImageView = UIImageView(image: UIImage(named: "title_view"))
        let width = min((view.bounds.width - 2 * tableViewWidth) * 0.5, 400)
        appIconImageView.frame.size = CGSize(width: width, height: width)
        appIconImageView.center.x = view.center.x
        appIconImageView.frame.origin.y = 100
        appIconImageView.layer.cornerRadius = appIconImageView.bounds.size.width * 0.2237
        appIconImageView.layer.masksToBounds = true

        // Configure table views
        [cmTableView1, inchTableView2].forEach { $0.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: view.bounds.size.height) }
        [inchTableView1, cmTableView2].forEach { $0.frame = CGRect(x: view.bounds.size.width - tableViewWidth, y: 0, width: tableViewWidth, height: view.bounds.size.height) }

        [cmTableView2, inchTableView2].forEach { $0.alpha = 0 }

        [cmTableView1, cmTableView2].forEach { $0.rowHeight = Dimension.pointsPerCentimeter }
        [inchTableView1, inchTableView2].forEach { $0.rowHeight = Dimension.pointsPerInch }

        [cmTableView1, cmTableView2, inchTableView1, inchTableView2].forEach { tableView in
            tableView.isUserInteractionEnabled = false
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            tableView.clipsToBounds = false
        }

        // Configure table view managers
        [cmTableView1, cmTableView2].forEach {
            $0.dataSource = cmTableViewManager
            $0.delegate = cmTableViewManager
        }

        [inchTableView1, inchTableView2].forEach {
            $0.dataSource = inchTableViewManager
            $0.delegate = inchTableViewManager
        }

        // Configure scroll view
        scrollView.frame = view.bounds
        scrollView.backgroundColor = .clear
        scrollView.decelerationRate = 0.01
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize.height = CGFloat(cmCount) * Dimension.pointsPerCentimeter

        // Add views
        view.addSubview(launchScreenView)
        view.addSubview(appIconImageView)
        view.addSubview(scrollView)
        view.addSubview(cmTableView1)
        view.addSubview(cmTableView2)
        view.addSubview(inchTableView1)
        view.addSubview(inchTableView2)

        // Add gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchSides))
        view.addGestureRecognizer(tap)
    }

    @objc
    func switchSides() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.5, animations: {
            let isFirstViewMode = self.cmTableView1.alpha == 1
            [self.cmTableView1, self.inchTableView1].forEach { $0.alpha = isFirstViewMode ? 0 : 1 }
            [self.cmTableView2, self.inchTableView2].forEach { $0.alpha = isFirstViewMode ? 1 : 0 }
        }) { _ in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Set new content offset also to table views
        [cmTableView1, cmTableView2, inchTableView1, inchTableView2].forEach { tableView in
            tableView.contentOffset.y = scrollView.contentOffset.y
            tableView.visibleCells.forEach { $0.layoutIfNeeded() }
        }
    }
}
