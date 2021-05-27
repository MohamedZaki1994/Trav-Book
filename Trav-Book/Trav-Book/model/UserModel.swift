//
//  UserModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/2/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String?
    let name: String?
    let username: String?
    let image:String?
    let birthdate: String?
    let region: String?
}
