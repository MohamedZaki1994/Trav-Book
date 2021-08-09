//
//  AuthProvider.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 9/28/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase
import Combine
import SwiftUI
import UIKit

class AuthProvider: ObservableObject {

    var didChange = PassthroughSubject<AuthProvider, Never>()
    @Published var user: CurrentUser? {
        didSet {
            self.didChange.send(self)
        }
    }
    var ref: DatabaseReference = Database.database().reference()
    var request = RequestHandler()
    var storage = Storage.storage().reference()
    static private var _shared = AuthProvider()
    static var shared: AuthProvider {
        return _shared
    }
    private init () {}

    func checkAuth() {
        ref.child("Users")
    }

    func createAccount(name:String, email: String, password: String, birthDate: String, country: String, image: UIImage?, completion: ((Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self](result, error) in
            if error == nil {
                guard let uid = result?.user.uid else {
                    completion?(errorType.invalidUid)
                    return
                }
                let data = image!.jpegData(compressionQuality: 0.2)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                self?.storage.child("Users").child(uid).putData(data!, metadata: metadata) { (metaData, error) in
                    if error != nil {
                        return
                    }
                }
                let jsonEncoder = JSONEncoder()
                let user = User(id: uid, name: name, username: email, image: "",birthdate: birthDate, region: country)
                let jsonData = try? jsonEncoder.encode(user)
                let json = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
                guard let userDictionary = json as? [String : Any] else {
                    return
                }
                self?.ref.child("Users").child(uid).setValue(userDictionary)
                print("Account created Successfully")
                completion?(nil)
            } else {
                print(error)
                completion?(error)
            }
        }
    }

    func getUserData(_ userUid: String,completion: ((Bool) -> Void)?) {
        self.request.getData(path: "Users/\(userUid)", modelType: User.self) {[weak self] (data, error) in
            let currentUser = data
            CurrentUser.shared.fillUserInfo(name: currentUser?.name ?? "", birthDate: currentUser?.birthdate ?? "", email: currentUser?.username ?? "", image: "", id: userUid, region: currentUser?.region ?? "")
            self?.user = CurrentUser.shared
            FirebaseManager.shared.getProfileImage { (_) in
            }
            completion?(true)
        }
    }


    func signIn(username: String, password: String, completion: ((Bool) -> Void)?) {
        Auth.auth().signIn(withEmail: username, password: password, completion: { [weak self](result, error) in
            guard let result = result else {
                completion?(false)
                return
            }
            let userUid = result.user.uid
            if error == nil {
                self?.getUserData(userUid) { (flag) in
                    completion?(flag)
                }
            }
        })
    }
    func signOut() {
        try? Auth.auth().signOut()
        user = nil
    }
}

enum errorType: Error {
    case invalidUid
}
