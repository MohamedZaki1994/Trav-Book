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

    var ref: DatabaseReference = Database.database().reference()
    @Published var status: Status = .initial

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

    func comment(currentPost: PostModel, comment: Comment) {
        var comments = currentPost.comments
        comments?.append(comment)
        var commentsInDic = [[String : Any]?]()
        comments?.forEach({ (comment) in
            commentsInDic.append(comment.dict)
        })
        guard let id = currentPost.id else {return}
        ref.child("Ref").child("Comments/\(id)").setValue(commentsInDic)
        status = .loading
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
