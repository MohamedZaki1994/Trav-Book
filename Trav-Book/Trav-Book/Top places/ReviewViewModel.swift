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
        request.load(path: "HotelsReviews/\(hotelName)", modelType: HotelReviewModel.self) { [weak self] (model, error) in
            self?.hotelReviews = model
            self?.status = .finished
        }
    }

    func uploadReview(reviewText: String, rate: Int, topPlaces: TopPlacesViewModel) {
        status = .loading
        guard let hotelIndex = topPlaces.dataModel?.firstIndex(where: { model in
            model.name == hotelName
        }) else { return }
        var isUserExist = false
        var userOldRate = 0
        hotelReviews?.forEach({
            if $0.userId == CurrentUser.shared.id {
                isUserExist = true
                userOldRate = $0.rate
            }
        })
        var wholeRating = topPlaces.dataModel?[hotelIndex].rating ?? 0

        var numberOfReviews = hotelReviews?.count ?? 0
        if isUserExist {
            wholeRating = checkUserIsAlreadyExist(rate: userOldRate, hotelIndex: hotelIndex, topPlaces: topPlaces)
            numberOfReviews -= 1
        }
        let oldRate = wholeRating * Double(numberOfReviews) / Double((numberOfReviews + 1))
        let averageRate = NSNumber(value: oldRate + (Double(rate) / Double((numberOfReviews + 1))))
        FirebaseManager.shared.uploadReview(reviewText: reviewText, rate: rate, hotelName: hotelName, numberOfReviews: hotelReviews?.count ?? 0, hotelIndex: hotelIndex, averageRate: averageRate) { [weak self](flag) in
            if flag {
                self?.status = .finished
                self?.fetchReviews(hotelName: self?.hotelName ?? "")
            }
        }
    }

    func loadImage(userId: String, completion: ((Data) -> Void)?) {
        FirebaseManager.shared.loadImage(userId: userId, completion: completion)
    }

    func checkUserIsAlreadyExist(rate: Int, hotelIndex: Int, topPlaces: TopPlacesViewModel) -> Double {
        let numberOfReviews = hotelReviews?.count ?? 0
        let wholeRating = topPlaces.dataModel?[hotelIndex].rating ?? 0
        let personOldRate = (Double(rate) / Double(numberOfReviews))
        return (wholeRating - personOldRate) * Double((numberOfReviews / (numberOfReviews - 1)))
    }
}
