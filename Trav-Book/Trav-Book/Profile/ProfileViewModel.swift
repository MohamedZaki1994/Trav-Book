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
    @Published var postsModel: PostsModel?
    @Published var isLoading = false

    init() {}

    func fillProfile() {
         profileModel = ProfileModel(name: "Zaki", birthday: "12-9-1994", region: "Egypt",gender: "male")
     }

    func loadUserPosts() {
        request.loadPosts(path: "UserPosts/\(CurrentUser.shared.id!)") { [weak self] (data, error) in
            self?.postsModel = data
            self?.posts = [PostModel]()
            guard let data = data else {return}
            for post in data.posts {
                self?.posts.append(PostModel(id: post.id, name: post.name, imagesNumber: post.imagesNumber, postText: post.post, numberOfLike: post.numberOfLike,numberOfDislike: post.numberOfDislike,comments: post.comments, date: post.date, profileImage: post.profileImage, userId: post.userId))
            }

        }
    }

}
