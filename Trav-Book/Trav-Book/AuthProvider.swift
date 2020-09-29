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
}
