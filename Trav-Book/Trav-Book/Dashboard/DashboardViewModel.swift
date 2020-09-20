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
                    self.posts.append(PostModel(name: post.name, imageName: nil, postText: post.post, numberOfLike: post.numberOfLike))
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
    }

    func getData() {
        var flag = true
        // dummy data from firebase
       ref.observe(DataEventType.value, with: { [weak self] (snapshot) in

        guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any, options: []) else { return }

        do {
            self?.postsModelUpdatedRealTime = try JSONDecoder().decode(PostsModel.self, from: data)
            if flag {
                self?.refresh()
                flag = false
            }
            print("Done")
        }
            
        catch {
            print(error)
        }


        })
    }

    func update(numberOfLikes: PostModel) {
        for post in posts.enumerated() {
            if post.element.id == numberOfLikes.id {

                ref.child("posts/\(post.offset)/numberOfLike").setValue(numberOfLikes.numberOfLike)
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
        init() {
            
        }
        init (name: String, imageName: String?,postText:String,numberOfLike: Int) {
            self.name = name
            self.imageName = imageName
            self.postText = postText
            self.numberOfLike = numberOfLike
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

struct PostsModel: Codable {
    let posts: [Post]
}

// MARK: - Post
struct Post: Codable{
    let name, post: String
    let numberOfLike: Int
}

