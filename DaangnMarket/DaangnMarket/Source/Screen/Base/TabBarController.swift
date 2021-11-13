//
//  TabBarController.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/13.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeTabBarItems()
        setTabBarAppearance()
    }
}

extension TabBarController {
    private func makeTabBarItems() {
        let home1View = Home1ViewController()
        home1View.tabBarItem = UITabBarItem()

        let home2View = Home2ViewController()
        home2View.tabBarItem = UITabBarItem()

        let myTownView = MyTownViewController()
        myTownView.tabBarItem = UITabBarItem()

        let chattingView = ChattingViewController()
        chattingView.tabBarItem = UITabBarItem()

        let myPageView = MyPageViewController()
        chattingView.tabBarItem = UITabBarItem()

        viewControllers = [
            home1View,
            home2View,
            myTownView,
            chattingView,
            myPageView
        ]
    }

    private func setTabBarAppearance() {
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().layer.borderWidth = 0.0
    }
}
