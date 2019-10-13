//
//  HomeViewController.swift
//  Trav Book
//
//  Created by Mohamed Mahmoud Zaki on 10/3/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class DashbaordTabBarController: UITabBarController, UITabBarControllerDelegate {

    let factory = AppFactory()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTabBars()
    }

    func makeTabBars() {
        let home = factory.makeHome()
        let profile = factory.makeProfile()
        let ask = factory.makeAsk()
        let notification = factory.makeNotification()
        let search = factory.makeSearch()
        let hometabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home.png"), selectedImage: nil)
        let profiletabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile.png"), selectedImage: nil)
        home.tabBarItem = hometabBarItem
        profile.tabBarItem = profiletabBarItem
        let saerchTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "search.jpg"), selectedImage: nil)
        let askTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "ask"), selectedImage: nil)
        search.tabBarItem = saerchTabBarItem
        ask.tabBarItem = askTabBarItem
        let notificationTabBarItem = UITabBarItem(title: "notification", image: UIImage(named: "notification"), selectedImage: nil)
        notification.tabBarItem = notificationTabBarItem
        viewControllers = [profile, home, search, ask, notification]
        delegate = self
        selectedIndex = 1
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
