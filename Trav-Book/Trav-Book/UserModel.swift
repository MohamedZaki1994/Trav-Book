//
//  UserModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/2/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: UUID
    let name: String
    let password: String
    let image:String
    let posts: PostsModel
    let favorite: PostsModel
}

struct PostsModel: Codable {
    let posts: [Post]
}

// MARK: - Post
struct Post: Codable{
    let name, post: String
    let numberOfLike: Int
}
