//
//  DashboardViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import Combine
class DashboardViewModel: ObservableObject {

    @Published var status: Status = .initial

    var ref: DatabaseReference = Database.database().reference()
    var request = RequestHandler()
    let storage = Storage.storage()

    var postsModel: PostModel? {
        didSet {
            posts.append(postsModel!)
        }
    }
    @Published var posts = [PostModel]()

    func getData() {
        status = .loading
        request.loadPosts(path: "Ref/posts") { [weak self] (data, error) in
            if error != nil {
                self?.status = .failure(error: error)
            }
            if let data = data {
                self?.posts = data
                self?.posts.sort(by: {
                    $0.date ?? 0 > $1.date ?? 0
                })
                self?.status = .finished
            }
            if self?.posts.isEmpty ?? true {
                self?.posts.append(PostModel(id: "", name: "", imagesNumber: 0, postText: "", numberOfLike: 0, numberOfDislike: 0, numberOfComments: 0, date: 0, profileImage: "", userId: "", place: ""))
                self?.status = .finished
            }
        }
    }

    func uploadPost(name: String, text: String, numberOfImages: Int, images: [UIImage?]?, place: String, completion: (() -> Void)? ) {
        FirebaseManager.shared.uploadPost(name: name, text: text, numberOfImages: numberOfImages, images: images, place: place, completion: completion)
        getData()
    }
}


class PostModel: Identifiable, ObservableObject, Codable {

    var id: String?
    var name: String?
    var profileImage: String?
    var imagesNumber: Int?
    var postText: String?
    var numberOfLike: Int?
    var numberOfDislike: Int?
    var numberOfComments: Int?
    var date: Double?
    var userId: String?
    var place: String
    var subscribers: [String]?

    init (id: String?, name: String, imagesNumber: Int,postText:String,numberOfLike: Int, numberOfDislike: Int, numberOfComments: Int, date: Double, profileImage: String, userId: String, place: String) {
        self.id = id
        self.name = name
        self.imagesNumber = imagesNumber
        self.postText = postText
        self.numberOfLike = numberOfLike
        self.numberOfDislike = numberOfDislike
        self.numberOfComments = numberOfComments
        self.date = date
        self.profileImage = profileImage
        self.userId = userId
        self.place = place
        subscribers = [userId]
    }
}

struct Comment: Codable, Identifiable {
    var id: String
    let name: String
    let ownerId: String
    let postId: String
    let postOwnerId: String
    let text: String
}


extension Encodable {

    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return nil }
        return json as? [String : Any]
    }
}
