//
//  ViewController.swift
//  Trav Book
//
//  Created by Mohamed Mahmoud Zaki on 10/1/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func later(_ sender: Any) {
        let tabbar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashbaordTabBarController")
        present(tabbar, animated: true, completion: nil)
    }

}

