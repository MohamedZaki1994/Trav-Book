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

    @Published var dataModel: TopPlacesModel?
    let storage = Storage.storage()
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

    func getImage(id: String, completion: ((UIImage) -> Void)?) {
        storage.reference().child("hotels").child(id).child(String(0)+".jpg").getData(maxSize: 1*2048*2048) { (data, error) in
                if let data = data, let image =  UIImage(data: data){
                    completion?(image)
                }
            }
    }
}
