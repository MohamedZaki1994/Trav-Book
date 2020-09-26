//
//  PostViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 9/20/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
class ProfileViewModel: ObservableObject {
    init() {}
    @Published var profileModel: ProfileModel = ProfileModel()

    func fillProfile() {
         profileModel = ProfileModel(name: "Zaki", birthday: "12-9-1994", region: "Egypt",gender: "male")
     }
}
