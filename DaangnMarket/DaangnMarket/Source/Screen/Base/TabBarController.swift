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
        makeBorder()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let itemView = item.value(forKey: "view") as? UIView else { return }
        let itemAnimator = UIViewPropertyAnimator(duration: 0.1, dampingRatio: 0.5) {
            itemView.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }
        itemAnimator.addAnimations({itemView.transform = .identity }, delayFactor: 0.5)
        itemAnimator.startAnimation()
   }
}

extension TabBarController {
    private func makeTabBarItems() {
        let home1View = Home1ViewController()
        home1View.tabBarItem = UITabBarItem(
            title: "홈",
            image: Image.homeIcon,
            selectedImage: Image.homeIcon
        )

        let home2View = Home2ViewController()
        home2View.tabBarItem = UITabBarItem(
            title: "동네생활",
            image: Image.neighborIcon,
            selectedImage: Image.neighborIcon
        )

        let myTownView = MyTownViewController()
        myTownView.tabBarItem = UITabBarItem(
            title: "내 근처",
            image: Image.locationIcon,
            selectedImage: Image.locationIcon
        )

        let chattingView = ChattingViewController()
        chattingView.tabBarItem = UITabBarItem(
            title: "채팅",
            image: Image.chatsIcon,
            selectedImage: Image.chatsIcon
        )

        let myPageView = MyPageViewController()
        myPageView.tabBarItem = UITabBarItem(
            title: "나의 당근",
            image: Image.myPageIcon,
            selectedImage: Image.myPageIcon
        )

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
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10, weight: .regular)],
                                                         for: .normal)
        UITabBar.appearance().tintColor = Color.daangnBlack1
        UITabBar.appearance().unselectedItemTintColor = Color.daangnBlack1
    }

    private func makeBorder() {
        tabBar.layer.borderColor = Color.daangnGray1.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
    }
}
