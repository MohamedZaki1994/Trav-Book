//
//  FirebaseManager.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 08/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Firebase
import SwiftUI
import UIKit

class FirebaseManager {
    var storage = Storage.storage().reference()
    var ref: DatabaseReference = Database.database().reference()
    static private let _shared = FirebaseManager()
    static var shared: FirebaseManager {
        return _shared
    }
    var cachingImage = NSCache<NSString, NSData>()

    private init(){}

    func updatePost(currentPost: PostModel, like: Bool?) {
        guard let id = currentPost.id else {return}
        guard let like = like else { return }
        if like {
            ref.child("Ref").child("posts/\(id)/numberOfLike").setValue(currentPost.numberOfLike)
            ref.child("UserPosts").child(currentPost.userId!).child(id).child("numberOfLike").setValue(currentPost.numberOfLike)
        } else {
            ref.child("Ref").child("posts/\(id)/numberOfDislike").setValue(currentPost.numberOfDislike)
            ref.child("UserPosts").child(currentPost.userId!).child(id).child("numberOfDislike").setValue(currentPost.numberOfDislike)
        }
    }

    func getHotelImage(for id:String, completion: ((Data) -> Void)?) {
        if let cachedNSDataImage = cachingImage.object(forKey: NSString(string: id)) {
            let cachedDataImage = Data(referencing: cachedNSDataImage)
            completion?(cachedDataImage)
            return
        }
        storage.child("hotels").child(id).child(String(0)+".jpg").getData(maxSize: 1*2048*2048) {[weak self] (data, error) in
            if let data = data {
                self?.cachingImage.setObject(NSData(data: data), forKey: NSString(string: id))
                completion?(data)
            }
        }
    }

    func updateProfileImage(image: UIImage, completion: ((Data) -> Void)?) {
        let data = image.jpegData(compressionQuality: 0.2)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        Storage.storage().reference().child("Users").child(CurrentUser.shared.id).putData(data!, metadata: metadata) { (metaData, error) in
            if error != nil {
                return
            }
        }
    }

    func getProfileImage(completion: ((Bool) -> Void)?) {
        storage.child("Users").child(CurrentUser.shared.id).getData(maxSize: 1*2048*2048) { (metaData, error) in
            if error == nil {
                CurrentUser.shared.profileImage = Image(uiImage: UIImage(data: metaData!)!)
                completion?(true)
            }
        }
    }

    func getProfileImage(for id: String, completion: ((Data) -> Void)?) {
        storage.child("Users").child(id).getData(maxSize: 1*2048*2048) { (metaData, error) in
            if error == nil {
                completion?(metaData!)
            }
        }
    }

    func uploadReview(reviewText: String, rate: Int, hotelName: String, numberOfReviews: Int, hotelIndex: Int, averageRate: NSNumber, completion: ((Bool) -> Void)?) {
        let dictionary = ["name": CurrentUser.shared.name, "image": "", "review": reviewText, "rate": rate] as [String : Any]
        ref.child("topPlaces").child(String(hotelIndex)).child("rating").setValue(averageRate)
        ref.child("HotelsReviews").child(hotelName).child(String(numberOfReviews)).updateChildValues(dictionary, withCompletionBlock: { (error, dataRef) in
            if error == nil {
                completion?(true)
            }
        })
//        ref.child("Hotels/\(hotelName)/reviews")
    }

    func uploadPost(name: String, text: String, numberOfImages: Int, images: [UIImage?]?, place: String, completion: (() -> Void)? ) {
        let postId = UUID().uuidString
        if images?.count ?? 0 > 0 {

            for (index,image) in images!.enumerated() {
                let data = image!.jpegData(compressionQuality: 0.2)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                storage.child("posts").child(postId).child("\(index)").putData(data!, metadata: metadata) { (meta, error) in
                    guard meta != nil else {
                        return
                    }
                    completion?()
                    print("Done")
                }
            }
        }
        let path = storage.child("posts").child(postId).child("0").fullPath
        ref.child("Ref").child("posts").child(postId).setValue(["id": postId,"imagesNumber": numberOfImages, "name" : name,"userId":CurrentUser.shared.id , "numberOfLike": 0,"postText": text, "numberOfDislike": 0, "numberOfComments": 0, "date": Date().timeIntervalSince1970, "profileImage": path, "place": place, "subscribers": [CurrentUser.shared.id]])
        ref.child("UserPosts").child(CurrentUser.shared.id).child(postId).setValue(["id": postId,"imagesNumber": numberOfImages, "name" : name,"userId":CurrentUser.shared.id , "numberOfLike": 0,"postText": text, "numberOfDislike": 0, "numberOfComments": 0, "date": Date().timeIntervalSince1970, "profileImage": path, "place": place])
    }

    func uploadComment(postId: String, userId: String, commentsInDic: [[String : Any]?]) {
        ref.child("Ref").child("Comments/\(postId)").setValue(commentsInDic)
        ref.child("Ref").child("posts/\(postId)").updateChildValues(["numberOfComments": commentsInDic.count])
        ref.child("UserPosts").child(userId).child(postId).updateChildValues(["numberOfComments": commentsInDic.count])
        ref.child("Ref/posts/\(postId)/subscribers").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            print(snapshot)
            guard var subscribers = snapshot.value as? [String] else {return}
            if !subscribers.contains(CurrentUser.shared.id) {
                subscribers.append(CurrentUser.shared.id)
                self?.ref.child("Ref/posts/\(postId)").updateChildValues(["subscribers": subscribers])
            }
        }
    }
}
