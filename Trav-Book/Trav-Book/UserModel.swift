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
    let posts: PostsModel?
    let favorite: PostsModel?
    let birthdate: String?
}

struct PostsModel: Codable {
    var posts: [Post]
}

// MARK: - Post
struct Post: Codable{
    let name, post: String
    let id: String
    let numberOfLike: Int
}
