//
//  UserInfo.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/13/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class UserInfo {
    var user: User?
    private static let share = UserInfo()
    static var shared: UserInfo {
        return share
    }
    private init() {
    }

    func resetUser() {
        user = nil
    }
}
