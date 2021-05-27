//
//  TopPlacesModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 27/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation


class TopPlacesModel: Codable, ObservableObject, Identifiable {
    var id: String?
    let name, region: String?
    let rating: Double?
    let price: Int?
    let photos: [String]?
    let email: String?
    let reviews: Int?

    init(id: String, name: String, region: String, rating: Double, price: Int, photos: [String], email: String, reviews: Int) {
        self.id = id
        self.name = name
        self.region = region
        self.rating = rating
        self.price = price
        self.photos = photos
        self.email = email
        self.reviews = reviews
    }
}

