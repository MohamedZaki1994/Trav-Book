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
                self?.status = .finished
            }
            if self?.posts.isEmpty ?? true {
                self?.posts.append(PostModel(id: "", name: "", imagesNumber: 0, postText: "", numberOfLike: 0, numberOfDislike: 0, numberOfComments: 0, date: 0, profileImage: "", userId: "", place: ""))
                self?.status = .finished
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

    /**
     upload a text

     - Parameters:
         - name: user name.
         - text: uploaded text

     */
    func postDummy(name: String, text: String, numberOfImages: Int, images: [UIImage?]?, place: String, completion: (() -> Void)? ) {
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
        let comment = Comment(name: "", id: "", text: "")
        ref.child("Ref").child("posts").child(postId).setValue(["id": postId,"imagesNumber": numberOfImages, "name" : name,"userId":CurrentUser.shared.id , "numberOfLike": 0,"postText": text, "numberOfDislike": 0, "numberOfComments": 0, "date": Date().timeIntervalSince1970, "profileImage": path, "place": place])
        ref.child("UserPosts").child(CurrentUser.shared.id).child(postId).setValue(["id": postId,"imagesNumber": numberOfImages, "name" : name,"userId":CurrentUser.shared.id , "numberOfLike": 0,"postText": text, "numberOfDislike": 0, "numberOfComments": 0, "date": Date().timeIntervalSince1970, "profileImage": path, "place": place])
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
    }
}

struct Comment: Codable, Identifiable {
    let uuid = UUID()
    let name: String
    let id: String
    let text: String
}


extension Encodable {

    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return nil }
        return json as? [String : Any]
    }
}
