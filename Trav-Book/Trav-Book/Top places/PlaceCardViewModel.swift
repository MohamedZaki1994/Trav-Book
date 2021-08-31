//
//  PlaceCardViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 03/06/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Firebase
class PlaceCardViewModel: ObservableObject {

    var cachingImage = NSCache<NSString, UIImage>()
    @Published var dataModel: TopPlacesModel?
    let storage = Storage.storage()
    var rating: String {
        return String(format: "%g", dataModel?.rating ?? 0)
    }
    func getRating(ratingNumber: Double) -> Rating {
        switch ratingNumber {
        case 0..<2.5:
            return .bad
        case 2.5..<3.5:
            return .good
        default:
            return .excellent
        }
    }

    func getImage(id: String, completion: ((UIImage) -> Void)?) {
        FirebaseManager.shared.getHotelImage(for: id) { (data) in
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion?(image)
                }
            }
        }
    }
}
