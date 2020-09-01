//
//  DashboardViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase

class DashboardViewModel: ObservableObject {

    var ref: DatabaseReference!
    var postsModelUpdatedRealTime : PostsModel?
    var postsModel: PostsModel? {
        didSet {
            if let postArray = postsModel?.posts {
                posts = [PostModel]()
                for post in postArray {
                    self.posts.append(PostModel(name: post.name, imageName: nil, postText: post.post))
                }

            }
        }
    }

    @Published var isLoading = false

    @Published var isRefresh = false
    @Published var posts = [PostModel]()
        {
        didSet {
            print("Fired")
            isLoading = false
        }
    }

    func refresh(){
        postsModel = postsModelUpdatedRealTime
    }

    func getData() {
        //Dummy data
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
//            let post1 = PostModel( name: "Zaki", imageName: "nothing", postText: "This is the best App")
//            let post2 = PostModel(name: "Onikage", imageName: nil, postText: "Agree")
//            let post3 = PostModel(name: "Omar", imageName: nil, postText: "Jehad")
//            let post4 = PostModel( name: "Zaki", imageName: "nothing", postText: "This is the best App")
//            let post5 = PostModel(name: "Onikage", imageName: nil, postText: "Agree")
//            let post6 = PostModel(name: "Omar", imageName: nil, postText: "Jehad")
//
//            self.posts = [post1,post2,post3,post4,post5,post6]
//        }
        // dummy data from cms
//        request { (welcome, error) in
//            print(welcome)
//        }

        // dummy data from firebase

        ref = Database.database().reference()
       ref.observe(DataEventType.value, with: { [weak self] (snapshot) in

        guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any, options: []) else { return }

        do {
            self?.postsModelUpdatedRealTime = try JSONDecoder().decode(PostsModel.self, from: data)
            print("Done")
        }
            
        catch {
            print(error)
        }


        })
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


    struct PostModel: Identifiable {

        var id = UUID()
        var name: String?
        var imageName: String?
        var postText: String?
}


// MARK: - Welcome
struct Welcome: Codable {
    let array: [Int]
    let boolean: Bool
    let color: String
    let null: JSONNull?
    let number: Int
    let object: Object
    let string: String
}

// MARK: - Object
struct Object: Codable {
    let a, c: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


struct PostsModel: Codable {
    let posts: [Post]
}

// MARK: - Post
struct Post: Codable{
    let name, post: String
}

