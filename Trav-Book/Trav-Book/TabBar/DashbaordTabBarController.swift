//
//  HomeViewController.swift
//  Trav Book
//
//  Created by Mohamed Mahmoud Zaki on 10/3/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class DashbaordTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
        let hometabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home.png"), selectedImage: nil)
        let profiletabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile.png"), selectedImage: nil)
        home.tabBarItem = hometabBarItem
        profile.tabBarItem = profiletabBarItem
        let search = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")
        let ask = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AskViewController")
        let saerchTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "search"), selectedImage: nil)
        let askTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "ask"), selectedImage: nil)
        search.tabBarItem = saerchTabBarItem
        ask.tabBarItem = askTabBarItem
        let notification = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController")

        let notificationTabBarItem = UITabBarItem(title: "notification", image: UIImage(named: "notification"), selectedImage: nil)
        notification.tabBarItem = notificationTabBarItem

        viewControllers = [home, profile, search, ask, notification]
        delegate = self

    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
