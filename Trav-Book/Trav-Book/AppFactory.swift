//
//  AppFactory.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/13/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import UIKit

class AppFactory {

    func makeTabBar() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashbaordTabBarController")
    }

    func makeHome() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
    }

    func makeProfile() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
    }

    func makeSearch() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")
    }

    func makeAsk() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AskViewController")
    }

    func makeNotification() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController")
    }
}
