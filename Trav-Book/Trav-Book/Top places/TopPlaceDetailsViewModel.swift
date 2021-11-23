//
//  TopPlaceDetailsViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import UIKit

class TopPlaceDetailsViewModel: ObservableObject {
    var image: UIImage?
    var name: String?
    @Published var model: HotelModel?
    @Published var hotelReviews: [HotelReviewModel]?
    let request = RequestHandler()
    var status: Status = .initial


    func getData() {
        status = .loading
        request.getData(path: "Hotels/\(name!)", modelType: HotelModel.self) {[weak self] (model, error) in
            self?.model = model
            self?.request.load(path: "HotelsReviews/\(self?.name! ?? "")", modelType: HotelReviewModel.self, limit: 2) { [weak self] (model, error) in
                self?.hotelReviews = model
                self?.status = .finished
            }
        }
    }
}
