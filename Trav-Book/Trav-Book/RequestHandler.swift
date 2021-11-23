//
//  RequestHandler.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 11/19/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase


class RequestHandler {
    var ref: DatabaseReference = Database.database().reference()

    func getData<T: Codable>(path: String, modelType: T.Type, completion:((T?, Error?) -> Void)?) {
        ref.child(path).observeSingleEvent(of: DataEventType.value, with: { snapshot in
            if snapshot.exists() {
                guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any, options: []) else { return }

                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion?(model,nil)
                }
                catch {
                    completion?(nil,error)
                    print(error)
                }

            } else {
                completion?(nil,nil)
            }})
    }
    var lastSnapshot: String? = ""
    func load<T: Codable>(path: String, modelType: T.Type, isFirst: Bool = true, limit: UInt = 3, completion:(([T]?, Error?) -> Void)?) {
        var query = ref.child(path).queryOrderedByKey()
        if !isFirst {
            query = query.queryEnding(atValue: lastSnapshot)
        }
        query.queryLimited(toLast: isFirst ? limit : limit + 1).observeSingleEvent(of: DataEventType.value) { (snapshot) in
            if snapshot.exists() {
                var arrayOfElement = [T]()
                var dataSnapshot = snapshot.children.allObjects as! [DataSnapshot]
                if !isFirst{
                    dataSnapshot.removeLast()
                }
                for postSnapshot in dataSnapshot {
                    let value = postSnapshot.value as! [String : AnyObject]
                    guard let data = try? JSONSerialization.data(withJSONObject: value, options: []) else { return }
                    do {
                    let singleElement = try JSONDecoder().decode(T.self, from: data)
                        arrayOfElement.append(singleElement)
                    }
                    catch {
                        print(error)
                    }
                }
                self.lastSnapshot = (snapshot.children.allObjects.first as? DataSnapshot)?.key
                completion?(arrayOfElement,nil)
            } else {
                completion?(nil,nil)
            }
        }
    }

    func loadPost(path: String ,completion:((PostModel?, Error?) -> Void)?) {
        ref.child(path).observeSingleEvent(of: DataEventType.value) { (snapshot) in
            if snapshot.exists() {
                guard let dictionary = snapshot.value as? [String: Any] else {return}
                guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return }
                do {
                    let postModel = try JSONDecoder().decode(PostModel.self, from: data)
                    completion?(postModel,nil)
                }
                catch {
                    print(error)
                }
            } else {
                completion?(nil,nil)
            }
        }
    }
}
