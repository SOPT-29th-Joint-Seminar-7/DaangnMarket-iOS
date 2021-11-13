//
//  MainNavigationController.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/14.
//

import UIKit

import Then

class MainNavigationController: BaseNavigationController {

    // MARK: - Properties
    private lazy var logoItem = UIBarButtonItem().then {
        let label = UILabel()
        label.text = "지역명"
        label.font = .systemFont(ofSize: 19, weight: .bold)
        $0.customView = label
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        initNavigationItem(navigationItem: rootViewController.navigationItem)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainNavigationController {
    private func initNavigationItem(navigationItem: UINavigationItem?) {
        let spacing = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacing.width = 12
        navigationItem?.leftBarButtonItem = logoItem
    }
}
