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
    @Published var commentModel = [Comment]()
    @Published var status: Status = .initial

    func loadComments(userId: String) {
        handler.load(path: "Ref/Comments/\(userId)", modelType: Comment.self) { [weak self] (commentsDataModel, error) in
            if error == nil, commentsDataModel != nil {
                if let data = commentsDataModel {
                    self?.commentModel = data
                    self?.commentModel.sort(by: {
                        $0.date < $1.date
                    })
                    self?.status = .finished
                }
            }
        }
    }

    func uploadComment(postId: String, userId: String, comment: String) {
        FirebaseManager.shared.uploadComment(comment: Comment(id: UUID().uuidString, name: CurrentUser.shared.name, ownerId: CurrentUser.shared.id, postId: postId, postOwnerId: userId, text: comment, date: Date().timeIntervalSince1970), numberOfComments: commentModel.count)
        status = .loading
    }
}
