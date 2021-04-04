//
//  CurrentUser.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/3/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI

class CurrentUser: ObservableObject {
    @Published var name: String?
    @Published var birthDate: String?
    @Published var email: String?
    @Published var image: String?
    @Published var posts: PostsModel?
    @Published var favorite: PostsModel?
    @Published var id: String?
    @Published var region: String?
    @Published var profileImage: Image?
    var ref: DatabaseReference = Database.database().reference()
    static var shared = CurrentUser()

    func fillUserInfo(name: String, birthDate: String, email: String, image: String, posts: PostsModel?, favorite: PostsModel?, id: String, region:String) {
        self.name = name
        self.birthDate = birthDate
        self.email = email
        self.image = image
        self.posts = posts
        self.favorite = favorite
        self.id = id
        self.region = region
    }

    func updateUserInfo() {
        self.ref.child("Users").child(id ?? "").child("name").setValue(name)
        self.ref.child("Users").child(id ?? "").child("region").setValue(region)
        self.ref.child("Users").child(id ?? "").child("birthdate").setValue(birthDate)
    }
    private init() {}
}
