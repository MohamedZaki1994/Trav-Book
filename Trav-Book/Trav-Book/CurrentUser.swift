//
//  CurrentUser.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/3/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class CurrentUser: ObservableObject {
    @Published var name: String?
    @Published var birthDate: String?
    @Published var email: String?
    @Published var image: String?
    @Published var posts: PostsModel?
    @Published  var favorite: PostsModel?

    static var shared = CurrentUser()
//   private init(name: String, birthDate: String, email: String, image: String, posts: PostsModel, favorite: PostsModel) {
//        self.name = name
//        self.birthDate = birthDate
//        self.email = email
//        self.image = image
//        self.posts = posts
//        self.favorite = favorite
//    }

    func fillUserInfo(name: String, birthDate: String, email: String, image: String, posts: PostsModel?, favorite: PostsModel?) {
        self.name = name
        self.birthDate = birthDate
        self.email = email
        self.image = image
        self.posts = posts
        self.favorite = favorite
    }
    private init() {}
}
