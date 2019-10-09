//
//  ViewController.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/3/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       GIDSignIn.sharedInstance()?.presentingViewController = self
    }


}

