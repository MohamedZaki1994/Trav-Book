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

    @Published var status: Status = .initial

    func update(currentPost: PostModel, like: Bool?) {
        FirebaseManager.shared.updatePost(currentPost: currentPost, like: like)
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
            FirebaseManager.shared.getProfileImage(for: post.userId!) { (data) in
                profileData = data
                dis.leave()
            }

            dis.notify(queue: DispatchQueue.global()) {
                completion?(datas, profileData!)
            }
//            }
        }
    }

    func deletePost(postId: String) {
        FirebaseManager.shared.deletePost(postId: postId)
    }
}
