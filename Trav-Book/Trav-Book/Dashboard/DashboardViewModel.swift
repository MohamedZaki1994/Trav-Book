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

    var ref: DatabaseReference = Database.database().reference()
    var switchSubscriber = Set<AnyCancellable>()
    var request = RequestHandler()
    var postsModel: PostsModel? {
        didSet {
            if let postArray = postsModel?.posts {
                posts = [PostModel]()
                for post in postArray {
                    self.posts.append(PostModel(id: post.id, name: post.name, imagesNumber: post.imagesNumber, postText: post.post, numberOfLike: post.numberOfLike,numberOfDislike: post.numberOfDislike,comments: post.comments, date: post.date))
                }

            }
            isLoading = false
        }
    }

    @Published var isLoading = false
    @Published var isRefresh = false
    @Published var posts = [PostModel]()

    func getData() {
        request.loadPosts { [weak self] (data, error) in
            self?.postsModel = data
            if self?.postsModel?.posts.isEmpty ?? true {
                let post = Post(name: "", post: "", id: "", imagesNumber: 0, numberOfLike: 0,numberOfDislike: 0,comments: [""], date: 0)
                self?.postsModel = PostsModel(posts: [post])
            }
        }
    }

//    func getImage(post: PostModel, completion: (([Data?]?) -> Void)?){
//        let counter = post.imagesNumber!
//        var datas = [Data]()
//        if counter > 0 {
//            for x in 0 ... counter-1 {
//                let storage = Storage.storage()
//                storage.reference().child(post.id!).child(String(x)).getData(maxSize: 1*2048*2048) { (data, error) in
//                    if data != nil {
//                        datas.append(data!)
//                        if x == counter - 1 {
//                            completion?(datas)
//                        }
//                    }
//                }
//            }
//        }
//    }
    func getImage(post: PostModel, completion: (([Data?]?) -> Void)?){
        let counter = post.imagesNumber!
        var datas = [Data]()
        if counter > 0 {
//            for x in 0 ... counter-1 {
                let storage = Storage.storage()
            storage.reference().child("posts").child(post.id!).child(String(0)).getData(maxSize: 1*2048*2048) { (data, error) in
                    if data != nil {
                        datas.append(data!)
//                        if x == counter - 1 {
                            completion?(datas)
//                        }
                    }
                }
//            }
        }
    }
    let storage = Storage.storage()
    func postDummy(name: String, text: String, numberOfImages: Int, images: [UIImage?]?, completion: (() -> Void)? ) {
        let numberOfPosts = postsModel?.posts.count ?? 0
        let postId = UUID().uuidString
        if images?.count ?? 0 > 0 {

            for (index,image) in images!.enumerated() {
                let data = image!.jpegData(compressionQuality: 0.2)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                storage.reference().child("posts").child(postId).child("\(index)").putData(data!, metadata: metadata) { (meta, error) in
                    guard meta != nil else {
                        return
                    }
                    completion?()
                    print("Done")
                }
            }
        }
        ref.child("Ref").child("posts").child(postId).setValue(["id": postId,"imagesNumber": numberOfImages, "name" : name, "numberOfLike": 0,"post": text, "numberOfDislike": 0, "comments": [""], "date": Date().timeIntervalSince1970])
        getData()
    }

    func update(currentPost: PostModel, like: Bool?) {
        guard let like = like else {
            let postIndex = (currentPost.comments?.count ?? 0)-1
            for post in posts.enumerated() {
                if post.element.id == currentPost.id {
                    ref.child("Ref").child("posts/\(post.offset)/comments").child("\(postIndex)").setValue(currentPost.comments?.last ?? "")
                }
            }
            return
        }
        if like {
            for post in posts.enumerated() {
                if post.element.id == currentPost.id {
                    ref.child("Ref").child("posts/\(post.offset)/numberOfLike").setValue(currentPost.numberOfLike)
                }
            }
        } else {
            for post in posts.enumerated() {
                if post.element.id == currentPost.id {
                    ref.child("Ref").child("posts/\(post.offset)/numberOfDislike").setValue(currentPost.numberOfDislike)
                }
            }
        }
    }

    func comment(currentPost: PostModel, comment: String) {
        for post in posts.enumerated() {
            if post.element.id == currentPost.id {
                let comment = "\(CurrentUser.shared.name!): \(comment)"
                post.element.comments?.append(comment)
                var nsArray = [String]()
                nsArray.append(contentsOf: post.element.comments!)
                post.element.comments = nsArray
                currentPost.comments = nsArray
                guard let id = post.element.id else {return}
                ref.child("Ref").child("posts/\(id)/comments").setValue(nsArray)
            }
        }
    }

    func request<T: Codable>(x: T.Type,completion:((T?, Error?) -> Void)?) {
        let urlComponent = URLComponents(string: "http://MohamedZaki1994.github.io/CMS/Test.json")
        guard let url = urlComponent?.url else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion?(nil, error)
                return
            }
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(T.self, from: data)
                    completion?(user ,nil)
                }
                catch {
                    print("error")
                }
            }
        }.resume()

    }
}


class PostModel: Identifiable, ObservableObject {

    var id: String?
    var name: String?
    var imagesNumber: Int?
    var postText: String?
    var numberOfLike: Int?
    var numberOfDislike: Int?
    var comments: [String]?
    var date: Double?
    init() {

    }
    init (id: String?, name: String, imagesNumber: Int,postText:String,numberOfLike: Int, numberOfDislike: Int, comments: [String], date: Double) {
        self.id = id
        self.name = name
        self.imagesNumber = imagesNumber
        self.postText = postText
        self.numberOfLike = numberOfLike
        self.numberOfDislike = numberOfDislike
        self.comments = comments
        self.date = date
    }
}


// MARK: - Welcome
struct Welcome: Codable {
    let array: [Int]
    let boolean: Bool
    let color: String
    let number: Int
    let string: String
}
