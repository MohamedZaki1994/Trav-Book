//
//  HotelModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 06/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

struct HotelModel: Codable {
    let email, name: String
    let photos: [String]
    let price: Int
    let rating: Double
    let region: String
    let reviews: [String]
    let hotelDescription, address: String
    let numberOfRooms: Int

    enum CodingKeys: String, CodingKey {
        case email, name, photos, price, rating, region, reviews
        case hotelDescription = "description"
        case address, numberOfRooms
    }
}
