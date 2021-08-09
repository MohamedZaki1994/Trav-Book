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
    @Published var status: Status = .initial
    let request = RequestHandler()
    var hotelName = ""

    func fetchReviews(hotelName: String) {
        status = .loading
        self.hotelName = hotelName
        request.getData(path: "HotelsReviews/\(hotelName)", modelType: [HotelReviewModel].self) {[weak self] (model, error) in
            self?.hotelReviews = model
            self?.status = .finished
        }
    }

    func uploadReview(reviewText: String, rate: Int) {
        status = .loading
        FirebaseManager.shared.uploadReview(reviewText: reviewText, rate: rate, hotelName: hotelName, numberOfReviews: hotelReviews?.count ?? 0) { [weak self](flag) in
            if flag {
                self?.status = .finished
                self?.fetchReviews(hotelName: self?.hotelName ?? "")
            }
        }
    }
}
