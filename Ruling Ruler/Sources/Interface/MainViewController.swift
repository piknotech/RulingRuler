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

    lazy var cmCount: Int = { Int(254.0 * countMultiplier) }()
    lazy var inchCount: Int = { Int(100.0 * countMultiplier) }()
    var cellWidth: CGFloat = 50
    lazy var tableViews: [UITableView] = {
        return [cmTableView1, cmTableView2, inchTableView1, inchTableView2]
    }()

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Private properties
    private let countMultiplier: Double = 1.0
    private var scrollView = UIScrollView()
    private var cmTableViewManager = CmTableViewManager()
    private var inchTableViewManager = InchTableViewManager()
    private var cmTableView1 = UITableView()
    private var cmTableView2 = UITableView()
    private var inchTableView1 = UITableView()
    private var inchTableView2 = UITableView()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get launcher view
        let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        let launchScreenView = launchScreen.view!
        launchScreenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Create app icon image view
        let appIconImageView = UIImageView(image: UIImage(named: "title_view"))
        let width = min((view.bounds.width - 2 * cellWidth) * 0.5, 400)
        appIconImageView.frame.size = CGSize(width: width, height: width)
        appIconImageView.center.x = view.center.x
        appIconImageView.frame.origin.y = 100
        appIconImageView.layer.cornerRadius = appIconImageView.bounds.size.width * 0.2237
        appIconImageView.layer.masksToBounds = true

        // Configure table view managers
        [cmTableView1, cmTableView2].forEach {
            $0.dataSource = cmTableViewManager
            $0.delegate = cmTableViewManager
        }

        [inchTableView1, inchTableView2].forEach {
            $0.dataSource = inchTableViewManager
            $0.delegate = inchTableViewManager
        }

        // Configure table views
        [cmTableView1, inchTableView2].forEach { $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.size.height) }
        [inchTableView1, cmTableView2].forEach { $0.frame = CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: view.bounds.size.height) }

        [cmTableView2, inchTableView2].forEach { $0.alpha = 0 }

        [cmTableView1, cmTableView2].forEach { $0.rowHeight = Dimension.pointsPerCentimeter }
        [inchTableView1, inchTableView2].forEach { $0.rowHeight = Dimension.pointsPerInch }

        tableViews.forEach { tableView in
            tableView.showsVerticalScrollIndicator = false
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
        }

        // Add views
        view.addSubview(launchScreenView)
        view.addSubview(appIconImageView)
        view.addSubview(cmTableView1)
        view.addSubview(cmTableView2)
        view.addSubview(inchTableView1)
        view.addSubview(inchTableView2)

        // Add gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchSides))
        view.addGestureRecognizer(tap)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Adjust for iPhone X
        if #available(iOS 11.0, *) {
            tableViews.forEach { tableView in
                print(tableView.contentInset.top, view.safeAreaInsets.top)
                tableView.contentInset.top = view.safeAreaInsets.top
                tableView.contentInset.bottom = view.safeAreaInsets.bottom
                tableView.contentInsetAdjustmentBehavior = .never
            }
        }
    }

    @objc
    func switchSides() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.2, animations: {
            let isFirstViewMode = self.cmTableView1.alpha == 1
            [self.cmTableView1, self.inchTableView1].forEach { $0.alpha = isFirstViewMode ? 0 : 1 }
            [self.cmTableView2, self.inchTableView2].forEach { $0.alpha = isFirstViewMode ? 1 : 0 }
        }) { _ in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
