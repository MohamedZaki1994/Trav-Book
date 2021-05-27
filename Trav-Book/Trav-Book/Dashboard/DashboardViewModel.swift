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
    let storage = Storage.storage()

    var postsModel: PostModel? {
        didSet {
//            if let postArray = postsModel?.posts {
//                posts = [PostModel]()
//                for post in postArray {
//                    self.posts.append(PostModel(id: post.id, name: post.name, imagesNumber: post.imagesNumber, postText: post.post, numberOfLike: post.numberOfLike,numberOfDislike: post.numberOfDislike,comments: post.comments, date: post.date, profileImage: post.profileImage, userId: post.userId))
//                }
//
//            }
            posts.append(postsModel!)
            isLoading = false
        }
    }

    @Published var isLoading = false
    @Published var isRefresh = false
    @Published var posts = [PostModel]()

    func getData() {
        request.loadPosts(path: "Ref/posts") { [weak self] (data, error) in
            self?.posts = data!
            if self?.posts.isEmpty ?? true {
                self?.posts.append(PostModel(id: "", name: "", imagesNumber: 0, postText: "", numberOfLike: 0, numberOfDislike: 0, comments: [""], date: 0, profileImage: "", userId: ""))
            }
            self?.isLoading = false
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

    /**
     upload a text

     - Parameters:
         - name: user name.
         - text: uploaded text

     */
    func postDummy(name: String, text: String, numberOfImages: Int, images: [UIImage?]?, completion: (() -> Void)? ) {
        let numberOfPosts = posts.count
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
        let path = storage.reference().child("posts").child(postId).child("0").fullPath
        ref.child("Ref").child("posts").child(postId).setValue(["id": postId,"imagesNumber": numberOfImages, "name" : name,"userId":CurrentUser.shared.id! , "numberOfLike": 0,"post": text, "numberOfDislike": 0, "comments": [""], "date": Date().timeIntervalSince1970, "profileImage": path])
        ref.child("UserPosts").child(CurrentUser.shared.id!).child(postId).setValue(["id": postId,"imagesNumber": numberOfImages, "name" : name,"userId":CurrentUser.shared.id! , "numberOfLike": 0,"post": text, "numberOfDislike": 0, "comments": [""], "date": Date().timeIntervalSince1970, "profileImage": path])
        getData()
    }

//    func request<T: Codable>(x: T.Type,completion:((T?, Error?) -> Void)?) {
//        let urlComponent = URLComponents(string: "http://MohamedZaki1994.github.io/CMS/Test.json")
//        guard let url = urlComponent?.url else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                completion?(nil, error)
//                return
//            }
//            if let data = data {
//                do {
//                    let user = try JSONDecoder().decode(T.self, from: data)
//                    completion?(user ,nil)
//                }
//                catch {
//                    print("error")
//                }
//            }
//        }.resume()
//
//    }
}


class PostModel: Identifiable, ObservableObject, Codable {

    var id: String?
    var name: String?
    var profileImage: String?
    var imagesNumber: Int?
    var postText: String?
    var numberOfLike: Int?
    var numberOfDislike: Int?
    var comments: [String]?
    var date: Double?
    var userId: String?
    var post: String?

    init (id: String?, name: String, imagesNumber: Int,postText:String,numberOfLike: Int, numberOfDislike: Int, comments: [String], date: Double,profileImage: String, userId: String) {
        self.id = id
        self.name = name
        self.imagesNumber = imagesNumber
        self.postText = postText
        self.numberOfLike = numberOfLike
        self.numberOfDislike = numberOfDislike
        self.comments = comments
        self.date = date
        self.profileImage = profileImage
        self.userId = userId
    }
}
