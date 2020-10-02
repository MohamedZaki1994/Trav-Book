//
//  AuthProvider.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 9/28/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase

class AuthProvider {
    var ref: DatabaseReference = Database.database().reference()
    static private var _shared = AuthProvider()
    static var shared: AuthProvider {
        return _shared
    }
    private init () {}

    func checkAuth() {
        ref.child("Users")
    }

    func createAccount(email: String, password: String, birthDate: String, image: String, completion: ((Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                result?.user.uid
                print("Account created Successfully")
                completion?(nil)
            } else {
                print(error)
                completion?(error)
            }
        }
    }
}
