//
//  DashboardViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase
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
                    self.posts.append(PostModel(name: post.name, imageName: nil, postText: post.post, numberOfLike: post.numberOfLike,numberOfDislike: post.numberOfDislike,comments: post.comments))
                }

            }
            print("Fired")
            isLoading = false
        }
    }

    @Published var isLoading = false
    @Published var isRefresh = false
    @Published var posts = [PostModel]()

    func refresh() {
        postsModel = postsModelUpdatedRealTime
        if postsModel?.posts.isEmpty ?? true{
            let post = Post(name: "", post: "", id: "", numberOfLike: 0,numberOfDislike: 0,comments: [""])
            postsModel = PostsModel(posts: [post])
        }
    }

    func getData() {
        ref.child("Ref").observeSingleEvent(of: DataEventType.value, with: { [weak self] (snapshot) in
            if snapshot.exists() {
                guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any, options: []) else { return }

                do {
                    self?.postsModelUpdatedRealTime = try JSONDecoder().decode(PostsModel.self, from: data)
                    self?.refresh()
                }
                catch {
                    print(error)
                }

            } else {
                self?.refresh()
            }})
    }

    func postDummy(name: String, text: String) {
        let numberOfPosts = postsModelUpdatedRealTime?.posts.count ?? 0
        ref.child("Ref").child("posts").child("\(String(describing: numberOfPosts))").setValue(["id": "", "name" : name, "numberOfLike": 0,"post": text, "numberOfDislike": 0, "comments": [""]])
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

    func request(completion:((Welcome?, Error?) -> Void)?) {
        let urlComponent = URLComponents(string: "http://MohamedZaki1994.github.io/CMS/Test.json")
        guard let url = urlComponent?.url else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion?(nil, error)
                return
            }
            var user: Welcome?
            if let data = data {
                do {
                    user = try JSONDecoder().decode(Welcome.self, from: data)
                    completion?(user,nil)
                }
                catch {
                    print("error")
                }
            }
        }.resume()

    }
}


class PostModel: Identifiable, ObservableObject {

    var id = UUID()
    var name: String?
    var imageName: String?
    var postText: String?
    var numberOfLike: Int?
    var numberOfDislike: Int?
    var comments: [String]?
    init() {

    }
    init (name: String, imageName: String?,postText:String,numberOfLike: Int, numberOfDislike: Int, comments: [String]) {
        self.name = name
        self.imageName = imageName
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

