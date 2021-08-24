//
//  NotificationPostViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 16/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase

class NotificationPostViewModel: ObservableObject {
    var ref: DatabaseReference = Database.database().reference()
    var request = RequestHandler()
    var postID = ""
    @Published var post: PostModel?
    @Published var status: Status = .initial

    func loadUserPost() {
        status = .loading
        request.loadPost(path: "Ref/posts/\(postID)") { [weak self] (data, error) in
            if let data = data {
                self?.post = data
                self?.status = .finished
            }
        }
    }
}
