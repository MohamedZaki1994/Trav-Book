//
//  HomePosts.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/27/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class HomePosts: Codable {
    var section: [Section]?

}

class Section: Codable {
    var title: String?
    var profilePic: String?
    var photo: String?
    var text: String?
}
