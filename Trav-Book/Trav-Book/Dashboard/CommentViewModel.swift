//
//  CommentViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 13/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase

class CommentViewModel: ObservableObject {
    let handler = RequestHandler()
    var ref: DatabaseReference = Database.database().reference()
    @Published var commentModel: [Comment]? = [Comment]()
    @Published var status: Status = .initial

    func loadComments(userId: String) {
        handler.getData(path: "Ref/Comments/\(userId)", modelType: [Comment].self) { [weak self] (model, error) in
            if error == nil, model != nil {
                self?.commentModel = model
                self?.status = .finished
            }
        }
    }

    func comment(postId: String, comment: Comment) {
        commentModel?.append(comment)
        var commentsInDic = [[String : Any]?]()
        commentModel?.forEach({ (comment) in
            commentsInDic.append(comment.dict)
        })
        ref.child("Ref").child("Comments/\(postId)").setValue(commentsInDic)
        ref.child("Ref").child("posts/\(postId)").updateChildValues(["numberOfComments": commentModel?.count ?? 0])
        status = .loading
    }
}
