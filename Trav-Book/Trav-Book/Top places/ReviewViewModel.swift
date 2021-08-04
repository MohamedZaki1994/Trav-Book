//
//  ReviewViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 04/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class ReviewViewModel: ObservableObject {
    @Published var hotelReviews: [HotelReviewModel]?
    let request = RequestHandler()
    var status: Status = .initial

    func fetchReviews(hotelName: String) {
        status = .loading
        request.getData(path: "HotelsReviews/\(hotelName)", modelType: [HotelReviewModel].self) {[weak self] (model, error) in
            self?.hotelReviews = model
            self?.status = .finished
        }
    }
}
