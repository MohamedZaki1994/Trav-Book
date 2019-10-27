//
//  Repository.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/27/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class Repository {

    class func getData(fileName: String, success: (HomePosts?, Error?) -> Void) {

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try JSONDecoder().decode(HomePosts.self, from: data)
                success(model, nil)
            } catch let error {
                success(nil, error)
                print(error)
            }
        }
    }
}
