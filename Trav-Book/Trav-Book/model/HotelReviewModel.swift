//
//  HotelReviewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 04/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

struct HotelReviewModel: Codable {
    let id = UUID()
    let name, review: String
    let userId: String
    let rate: Int
    let date: Double
}
