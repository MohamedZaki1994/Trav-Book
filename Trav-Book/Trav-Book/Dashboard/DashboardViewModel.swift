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
    var postsModelUpdatedRealTime : PostsModel?
    var switchSubscriber = Set<AnyCancellable>()
    var postsModel: PostsModel? {
        didSet {
            if let postArray = postsModel?.posts {
                posts = [PostModel]()
                for post in postArray {
                    self.posts.append(PostModel(id: post.id, name: post.name, imagesNumber: post.imagesNumber, postText: post.post, numberOfLike: post.numberOfLike,numberOfDislike: post.numberOfDislike,comments: post.comments))
                }

            }
            print("Fired")
            isLoading = false
        }
    }

    @Published var isLoading = false
    @Published var isRefresh = false
    @Published var posts = [PostModel]()
    var request = RequestHandler()
    func refresh() {
        postsModel = postsModelUpdatedRealTime
        if postsModel?.posts.isEmpty ?? true{
            let post = Post(name: "", post: "", id: "", imagesNumber: 0, numberOfLike: 0,numberOfDislike: 0,comments: [""])
            postsModel = PostsModel(posts: [post])
        }
    }

    func getData() {
        request.getData(path: "Ref", modelType: PostsModel.self) { [weak self] (data, error) in
            self?.postsModelUpdatedRealTime = data
            self?.refresh()
        }
    }

    func getImage(post: PostModel, completion: (([Data?]?) -> Void)?){
        let counter = post.imagesNumber!
        var datas = [Data]()
        if counter > 0 {
            for x in 0 ... counter-1 {
                let storage = Storage.storage()
                storage.reference().child(post.id!).child(String(x)).getData(maxSize: 1*2048*2048) { (data, error) in
                    if data != nil {
                        datas.append(data!)
                        if x == counter - 1 {
                            completion?(datas)
                        }
                    }
                }
            }
        }
    }
    let storage = Storage.storage()
    func postDummy(name: String, text: String, numberOfImages: Int, images: [UIImage?]?, completion: (() -> Void)? ) {
        let numberOfPosts = postsModelUpdatedRealTime?.posts.count ?? 0
        let id = UUID().uuidString
        if images?.count ?? 0 > 0 {

            storage.reference().child(id)
//
            for (index,image) in images!.enumerated() {
//                let data = image!.pngData()
                let data = image!.jpegData(compressionQuality: 0.2)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                storage.reference().child(id).child("\(index)").putData(data!, metadata: metadata) { (meta, error) in
                    guard meta != nil else {
                        return
                    }
                    completion?()
                    print("Done")
                }
            }
//
        }
        ref.child("Ref").child("posts").child("\(String(describing: numberOfPosts))").setValue(["id": id,"imagesNumber": numberOfImages, "name" : name, "numberOfLike": 0,"post": text, "numberOfDislike": 0, "comments": [""]])
        getData()
    }

    func update(numberOfLikes: PostModel, like: Bool?) {
        guard let like = like else {
            let postIndex = (numberOfLikes.comments?.count ?? 0)-1
            for post in posts.enumerated() {
                if post.element.id == numberOfLikes.id {
                    ref.child("Ref").child("posts/\(post.offset)/comments").child("\(postIndex)").setValue(numberOfLikes.comments?.last ?? "")
                }
            }
            return
        }
        if like {
            for post in posts.enumerated() {
                if post.element.id == numberOfLikes.id {
                    ref.child("Ref").child("posts/\(post.offset)/numberOfLike").setValue(numberOfLikes.numberOfLike)
                }
            }
        } else {
            for post in posts.enumerated() {
                if post.element.id == numberOfLikes.id {
                    ref.child("Ref").child("posts/\(post.offset)/numberOfDislike").setValue(numberOfLikes.numberOfDislike)
                }
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
    init() {

    }
    init (id: String?, name: String, imagesNumber: Int,postText:String,numberOfLike: Int, numberOfDislike: Int, comments: [String]) {
        self.id = id
        self.name = name
        self.imagesNumber = imagesNumber
        self.postText = postText
        self.numberOfLike = numberOfLike
        self.numberOfDislike = numberOfDislike
        self.comments = comments
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
