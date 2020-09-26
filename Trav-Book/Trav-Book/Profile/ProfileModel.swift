//
//  ProfileModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 9/20/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class ProfileModel: Codable {
    var name: String
    var birthday: String
    var region: String
    var gender: String
    init() {
        name = ""
        birthday = ""
        region = ""
        gender = ""
    }
    init(name: String, birthday: String, region: String, gender: String) {
        self.name = name
        self.birthday = birthday
        self.region = region
        self.gender = gender
    }
}
