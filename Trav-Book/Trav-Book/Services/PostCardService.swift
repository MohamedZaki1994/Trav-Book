//
//  PostCardService.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 08/03/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase

// to be continue
class PostCardService: ObservableObject {

    @Published var posts = [PostModel]()
    var ref: DatabaseReference = Database.database().reference()

    func update(currentPost: PostModel, like: Bool?) {
        guard let like = like else {
            let postIndex = (currentPost.comments?.count ?? 0)-1
            for post in posts.enumerated() {
                if post.element.id == currentPost.id {
                    ref.child("Ref").child("posts/\(post.offset)/comments").child("\(postIndex)").setValue(currentPost.comments?.last ?? "")
                }
            }
            return
        }
        if like {
            for post in posts.enumerated() {
                if post.element.id == currentPost.id {
                    ref.child("Ref").child("posts/\(post.offset)/numberOfLike").setValue(currentPost.numberOfLike)
                }
            }
        } else {
            for post in posts.enumerated() {
                if post.element.id == currentPost.id {
                    ref.child("Ref").child("posts/\(post.offset)/numberOfDislike").setValue(currentPost.numberOfDislike)
                }
            }
        }
    }
}
