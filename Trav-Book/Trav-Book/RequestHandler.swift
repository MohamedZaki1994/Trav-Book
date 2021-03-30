//
//  RequestHandler.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 11/19/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase


class RequestHandler {
    var ref: DatabaseReference = Database.database().reference()

    func getData<T: Codable>(path: String, modelType: T.Type, completion:((T?, Error?) -> Void)?) {
        ref.child(path).observeSingleEvent(of: DataEventType.value, with: { [weak self] (snapshot) in
            if snapshot.exists() {
                guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any, options: []) else { return }

                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion?(model,nil)
                }
                catch {
                    completion?(nil,error)
                    print(error)
                }

            } else {
                completion?(nil,nil)
            }})
    }

    func loadPosts(completion:((PostsModel?, Error?) -> Void)?) {
        ref.child("Ref").child("posts").observeSingleEvent(of: DataEventType.value) { (snapshot) in
            if snapshot.exists() {
                var posts = [Post]()
                guard let dictionary = snapshot.value as? [String: Any] else {return}
                for (key,value) in dictionary {
                    guard let data = try? JSONSerialization.data(withJSONObject: value, options: []) else { return }
                    guard let postModel = try? JSONDecoder().decode(Post.self, from: data) else {return}
                    posts.append(postModel)
                }
                completion?(PostsModel(posts: posts),nil)
            } else {
                completion?(nil,nil)
            }
        }
    }
}
