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

    func createAccount(name:String, email: String, password: String, birthDate: String, image: String, completion: ((Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                guard let uid = result?.user.uid else {
                    completion?(errorType.invalidUid)
                    return
                }
                let jsonEncoder = JSONEncoder()
                let user = User(id: uid, name: name, username: email, image: "", posts: nil, favorite: nil,birthdate: birthDate)
                let jsonData = try? jsonEncoder.encode(user)
                let json = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
                guard let userDictionary = json as? [String : Any] else {
                    return
                }
                self.ref.child("Users").child(uid).setValue(userDictionary)
                print("Account created Successfully")
                completion?(nil)
            } else {
                print(error)
                completion?(error)
            }
        }
    }

    func signIn(username: String, password: String, completion: ((Bool) -> Void)?) {
        Auth.auth().signIn(withEmail: username, password: password, completion: { (result, error) in
            guard let result = result else {
                completion?(false)
                return
            }
            let userUid = result.user.uid
            if error == nil {
                self.ref.child("Users").child(userUid).observeSingleEvent(of: DataEventType.value) { (snapshot) in
                    guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any, options: []) else { return }
                    do {
                        let currentUser = try JSONDecoder().decode(User.self, from: data)
                        CurrentUser.shared.fillUserInfo(name: currentUser.name ?? "", birthDate: currentUser.birthdate ?? "", email: currentUser.username ?? "", image: "", posts: nil, favorite: nil, id: result.user.uid)
                        completion?(true)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        })
    }
}

enum errorType: Error {
    case invalidUid
}
