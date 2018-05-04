//
//  ViewController.swift
//  Ruling Ruler
//
//  Created by Frederick Pietschmann on 04.11.17.
//  Copyright © 2017-2018 Piknotech. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Properties
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

    private let countMultiplier: Double = 2.0
    private var scrollView = UIScrollView()
    private var cmTableViewManager = CmTableViewManager()
    private var inchTableViewManager = InchTableViewManager()
    private var cmTableView1 = UITableView()
    private var cmTableView2 = UITableView()
    private var inchTableView1 = UITableView()
    private var inchTableView2 = UITableView()
    private var phantomScrollView = UIScrollView()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackground()
        configureTableViews()
        configurePhantomScrollView()

        let tap = UITapGestureRecognizer(target: self, action: #selector(switchSides))
        view.addGestureRecognizer(tap)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Adjust for iPhone X
        if #available(iOS 11.0, *) {
            tableViews.forEach { tableView in
                tableView.contentInset.top = view.safeAreaInsets.top
                tableView.contentInset.bottom = view.safeAreaInsets.bottom
                tableView.contentInsetAdjustmentBehavior = .never
            }
        }
    }

    // MARK: Layout
    private func configureBackground() {
        let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        let launchScreenView = launchScreen.view!
        launchScreenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let titleView = UIImageView(image: #imageLiteral(resourceName: "title_view"))
        let width = min((view.bounds.width - 2 * cellWidth) * 0.5, 400)
        titleView.frame.size = CGSize(width: width, height: width)
        titleView.center.x = view.center.x
        titleView.frame.origin.y = 100

        view.addSubview(launchScreenView)
        view.addSubview(titleView)
    }

    private func configureTableViews() {
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
        [cmTableView1, inchTableView2].forEach {
            $0.frame = CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width / 2,
                height: view.bounds.size.height
            )
        }

        [inchTableView1, cmTableView2].forEach {
            $0.frame = CGRect(
                x: view.bounds.width / 2,
                y: 0,
                width: view.bounds.width / 2,
                height: view.bounds.size.height
            )
        }

        [cmTableView2, inchTableView2].forEach { $0.alpha = 0 }

        [cmTableView1, cmTableView2].forEach { $0.rowHeight = DimensionInfo.pointsPerCentimeter }
        [inchTableView1, inchTableView2].forEach { $0.rowHeight = DimensionInfo.pointsPerInch }

        tableViews.forEach { tableView in
            tableView.isUserInteractionEnabled = false
            tableView.showsVerticalScrollIndicator = false
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
        }

        view.addSubview(cmTableView1)
        view.addSubview(cmTableView2)
        view.addSubview(inchTableView1)
        view.addSubview(inchTableView2)
    }

    private func configurePhantomScrollView() {
        phantomScrollView.frame = view.bounds
        phantomScrollView.showsVerticalScrollIndicator = false
        phantomScrollView.showsHorizontalScrollIndicator = false
        phantomScrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: DimensionInfo.pointsPerCentimeter * CGFloat(cmCount)
        )
        phantomScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        phantomScrollView.delegate = self

        view.addSubview(phantomScrollView)
    }

    // MARK: Switching
    @objc
    func switchSides() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            let isFirstViewMode = self.cmTableView1.alpha == 1
            [self.cmTableView1, self.inchTableView1].forEach { $0.alpha = isFirstViewMode ? 0 : 1 }
            [self.cmTableView2, self.inchTableView2].forEach { $0.alpha = isFirstViewMode ? 1 : 0 }
        }, completion: { _ in
            UIApplication.shared.endIgnoringInteractionEvents()
            FabricManager.shared.log(.sidesSwitched)
        })
    }

    // MARK: Scrolling
    func scrollTableViews(to yOffset: CGFloat, animated: Bool = false) {
        tableViews.forEach {
            $0.setContentOffset(CGPoint(x: 0, y: yOffset), animated: animated)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollTableViews(to: scrollView.contentOffset.y)
    }
}
