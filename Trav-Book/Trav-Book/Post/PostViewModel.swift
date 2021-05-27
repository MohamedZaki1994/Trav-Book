//
//  PostViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 08/03/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase

class PostViewModel: ObservableObject {

//    @Published var posts = [PostModel]()
    var ref: DatabaseReference = Database.database().reference()

    func update(currentPost: PostModel, like: Bool?) {
        guard let id = currentPost.id else {return}
        guard let like = like else { return }
        if like {
            ref.child("Ref").child("posts/\(id)/numberOfLike").setValue(currentPost.numberOfLike)
            ref.child("UserPosts").child(currentPost.userId!).child(id).child("numberOfLike").setValue(currentPost.numberOfLike)
        } else {
            ref.child("Ref").child("posts/\(id)/numberOfDislike").setValue(currentPost.numberOfDislike)
            ref.child("UserPosts").child(currentPost.userId!).child(id).child("numberOfDislike").setValue(currentPost.numberOfDislike)
        }
    }

    func comment(currentPost: PostModel, comment: String) {
        let comment = "\(CurrentUser.shared.name!): \(comment)"
        currentPost.comments?.append(comment)
        var nsArray = [String]()
        nsArray.append(contentsOf: currentPost.comments!)
        currentPost.comments = nsArray
        guard let id = currentPost.id else {return}
        ref.child("Ref").child("posts/\(id)/comments").setValue(nsArray)
        ref.child("UserPosts").child("\(currentPost.userId!)/\(id)/comments").setValue(nsArray)
    }

    func getImage(post: PostModel, completion: (([Data?]?, Data) -> Void)?){
        let counter = post.imagesNumber!
        var datas = [Data]()
        var profileData: Data?
        if counter > 0 {
//            for x in 0 ... counter-1 {
                let storage = Storage.storage()
            let dis = DispatchGroup()
            dis.enter()
            storage.reference().child("posts").child(post.id!).child(String(0)).getData(maxSize: 1*2048*2048) { (data, error) in
                    if data != nil {
                        datas.append(data!)
//                        if x == counter - 1 {
                        dis.leave()
//                        }
                    }
                }
            dis.enter()
            AuthProvider.shared.getProfileImage(for: post.userId!) { (data) in
                profileData = data
                dis.leave()
            }

            dis.notify(queue: DispatchQueue.global()) {
                completion?(datas, profileData!)
            }
//            }
        }
    }
}
