//
//  ProfileViewController.swift
//  Trav Book
//
//  Created by Mohamed Mahmoud Zaki on 10/3/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import GoogleSignIn
class ProfileViewController: UIViewController {

    let user = UserInfo.shared.user
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBAction func singout(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        UserInfo.shared.resetUser()
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.sd_setImage(with: user?.imageURL, completed: nil)
        username.text = user?.fullName
    }
}
