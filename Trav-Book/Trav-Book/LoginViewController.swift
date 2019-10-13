//
//  ViewController.swift
//  Trav Book
//
//  Created by Mohamed Mahmoud Zaki on 10/1/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    let appFactory = AppFactory()
    @IBAction func googleSignInButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self

    }

    @IBAction func later(_ sender: Any) {
        let tabbar = appFactory.makeTabBar() as? UITabBarController
        tabbar?.selectedIndex = 1
        present(tabbar!, animated: true, completion: nil)
    }

}

