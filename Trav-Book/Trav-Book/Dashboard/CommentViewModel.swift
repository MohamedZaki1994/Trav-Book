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
        handler.loadComments(path: "Ref/Comments/\(userId)") { [weak self] (commentsDataModel, error) in
            if error == nil, commentsDataModel != nil {
                self?.commentModel = commentsDataModel
                self?.status = .finished
            }
        }
    }

    func uploadComment(postId: String, userId: String, comment: String) {
        FirebaseManager.shared.uploadComment(userId: userId, comment: Comment(id: UUID().uuidString, name: CurrentUser.shared.name, ownerId: CurrentUser.shared.id, postId: postId, text: comment), numberOfComments: commentModel?.count ?? 0)
        status = .loading
    }
}
