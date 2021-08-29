//
//  SingleCommentViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 13/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class SingleCommentViewModel: ObservableObject {
    var storage = Storage.storage().reference()
    @Published var image: Image?

    func loadImage(userId: String, completion: ((Data) -> Void)?) {
        FirebaseManager.shared.loadImage(userId: userId, completion: completion)
    }

    func deleteComment(comment: Comment, numberOfComments: Int) {
        FirebaseManager.shared.deleteComment(comment: comment, numberOfComments: numberOfComments)
    }
}
