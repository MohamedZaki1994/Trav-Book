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

    func uploadReview(reviewText: String, rate: Int, topPlaces: TopPlacesViewModel) {
        status = .loading

        guard let hotelIndex = topPlaces.dataModel?.firstIndex(where: { model in
            model.name == hotelName
        }) else { return }

        let wholeRating = topPlaces.dataModel?[hotelIndex].rating ?? 0
        let numberOfReviews = hotelReviews?.count ?? 0
        let oldRate = wholeRating * Double(numberOfReviews) / Double((numberOfReviews + 1))
        let averageRate = NSNumber(value: oldRate + (Double(rate) / Double((numberOfReviews + 1))))
//        let averageRate = NSNumber(value: (wholeRating + Double(rate)) / (Double(numberOfReviews +1 )))
        FirebaseManager.shared.uploadReview(reviewText: reviewText, rate: rate, hotelName: hotelName, numberOfReviews: hotelReviews?.count ?? 0, hotelIndex: hotelIndex, averageRate: averageRate) { [weak self](flag) in
            if flag {
                self?.status = .finished
                self?.fetchReviews(hotelName: self?.hotelName ?? "")
            }
        }
    }
}
