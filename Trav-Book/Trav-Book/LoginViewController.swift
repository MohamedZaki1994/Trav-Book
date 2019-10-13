//
//  ViewController.swift
//  Trav Book
//
//  Created by Mohamed Mahmoud Zaki on 10/1/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import GoogleSignIn
import SDWebImage

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }
        guard let user = user else {
            return
        }
        let signedInUser = User(userId: user.userID,
                                idToken: user.authentication.idToken,
                                fullName: user.profile.name,
                                givenName: user.profile.givenName,
                                familyName: user.profile.familyName,
                                email: user.profile.email,
                                imageURL: user.profile.imageURL(withDimension: UInt(200)))
        imageView.sd_setImage(with: user.profile.imageURL(withDimension: UInt(200)), completed: nil)
    }

    let appFactory = AppFactory()
    @IBAction func googleSignInButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.delegate = self
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

