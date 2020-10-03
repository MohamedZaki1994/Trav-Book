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
//    var currentUserUid: String?
    private init () {}

    func checkAuth() {
        ref.child("Users")
    }

    func createAccount(email: String, password: String, birthDate: String, image: String, completion: ((Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                guard let uid = result?.user.uid else {
                    completion?(errorType.invalidUid)
                    return
                }
                let jsonEncoder = JSONEncoder()
                let user = User(id: uid, name: "Zaki", password: "", image: "", posts: nil, favorite: nil)
                let jsonData = try? jsonEncoder.encode(user)
                let json = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
                guard let userDictionary = json as? [String : Any] else {
                    return
                }
                self.ref.child("Users").child(uid).setValue(userDictionary)
//                self.currentUserUid = uid
                print("Account created Successfully")
                completion?(nil)
            } else {
                print(error)
                completion?(error)
            }
        }
    }
}

enum errorType: Error {
    case invalidUid
}
