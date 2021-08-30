//
//  ProfileViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 9/20/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase
class ProfileViewModel: ObservableObject {
    var ref: DatabaseReference = Database.database().reference()
    var request = RequestHandler()
    @Published var profileModel: ProfileModel = ProfileModel()
    @Published var posts = [PostModel]()
    @Published var status: Status = .initial

    func loadUserPosts() {
        status = .loading
        request.load(path: "UserPosts/\(CurrentUser.shared.id)", modelType: PostModel.self) { [weak self] (data, error) in
            if error == nil, data == nil {
                self?.status = .finished
            }
            if let data = data {
                self?.posts = data
                self?.posts.sort(by: {
                    $0.date ?? 0 > $1.date ?? 0
                })
                self?.status = .finished
            }
        }
    }

}
