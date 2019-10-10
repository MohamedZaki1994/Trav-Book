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

    @IBAction func googleSignInButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        let signinGoogle = GIDSignInButton(frame: CGRect(x: 20, y: 100, width: view.frame.width - 50, height: 100))
//        view.addSubview(signinGoogle)

    }

    @IBAction func later(_ sender: Any) {
        let tabbar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashbaordTabBarController")
        present(tabbar, animated: true, completion: nil)
    }

}

