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
        storage.child("Users").child(userId).getData(maxSize: 1*2048*2048) { (metaData, error) in
            if error == nil {
                completion?(metaData!)
            }
        }
    }

    func deleteComment(comment: Comment, numberOfComments: Int) {
        FirebaseManager.shared.deleteComment(comment: comment, numberOfComments: numberOfComments)
    }
}
