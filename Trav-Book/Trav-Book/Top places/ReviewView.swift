//
//  ReviewView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 04/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct ReviewView: View {
    @StateObject var viewModel = ReviewViewModel()
    @State var hotelName: String
    @State var reviewText: String = ""
    @State var lastFullStar = 2
    @State var image: Image?
    @EnvironmentObject var topPlaces: TopPlacesViewModel
    var body: some View {
        switch viewModel.status {
        case .initial:
            Text("")
                .onAppear() {
                    viewModel.fetchReviews(hotelName: hotelName)
            }
        case .loading:
            Text("")
        case .finished:
            List {
                if let reviews = viewModel.hotelReviews {
                    ForEach(reviews.reversed(), id: \.id) { review in
                        SingleReviewView(review: review)
                    }
                }
            }
            StarsView(isEditable: true, lastFullStar: lastFullStar) { (rate) in
                lastFullStar = rate
            }
            HStack {
                TextField("write a review", text: $reviewText).padding()
                Button("done") {
                    viewModel.uploadReview(reviewText: reviewText, rate: lastFullStar, topPlaces: topPlaces)
                    topPlaces.getData()
                    reviewText = ""
                    lastFullStar = 2
                }
                .padding()
            }
        case .failure(error: let error):
            Text(error.debugDescription)
        }
    }
}
