//
//  SignupViewmodel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 10/9/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class SignupViewmodel {

    func signup(name: String,email: String, password: String, birthdate: Date, country: String, completion: ((Bool) -> Void)?) {
        AuthProvider.shared.createAccount(name: name, email: email, password: password,birthDate: birthdate.toString(), image: "", country: country) { (error) in
            if error == nil {
                completion?(true)
            }
        }
    }
}
