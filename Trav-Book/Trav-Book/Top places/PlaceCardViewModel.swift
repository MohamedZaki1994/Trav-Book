//
//  PlaceCardViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 03/06/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import SwiftUI
struct PlaceCardViewModel {
    func getRating(ratingNumber: Double) -> Rating {
        switch ratingNumber {
        case 0..<5:
            return .bad
        case 5..<7.5:
            return .good
        default:
            return .excellent
        }
    }

    func getImage() {

    }
}
