//
//  TopPlacesModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 27/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation


class TopPlacesModel: Codable, Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String?
    @Published var region: String?
    @Published var rating: Double?
    @Published var price: Int?
    @Published var photos: [String]?
    @Published var email: String?
    @Published var reviews: Int?
    enum CodingKeys: CodingKey {
        case name
        case region
        case rating
        case price
        case photos
        case email
        case reviews
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        region = try container.decode(String.self, forKey: .region)
        rating = try container.decode(Double.self, forKey: .rating)
        price = try container.decode(Int.self, forKey: .price)
        photos = try container.decode([String].self, forKey: .photos)
        email = try container.decode(String.self, forKey: .email)
        reviews = try container.decode(Int.self, forKey: .reviews)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(region, forKey: .region)
        try container.encode(rating, forKey: .rating)
        try container.encode(price, forKey: .price)
        try container.encode(photos, forKey: .photos)
        try container.encode(email, forKey: .email)
        try container.encode(reviews, forKey: .reviews)
    }

    init(name: String, region: String, rating: Double, price: Int, photos: [String], email: String, reviews: Int) {
        self.name = name
        self.region = region
        self.rating = rating
        self.price = price
        self.photos = photos
        self.email = email
        self.reviews = reviews
    }
}

