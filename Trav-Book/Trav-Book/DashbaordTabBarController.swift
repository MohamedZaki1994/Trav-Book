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
        let hometabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        let profiletabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        home.tabBarItem = hometabBarItem
        profile.tabBarItem = profiletabBarItem
        viewControllers = [home, profile]
        delegate = self

    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
