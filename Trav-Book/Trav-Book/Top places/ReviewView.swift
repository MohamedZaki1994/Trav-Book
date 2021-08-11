//
//  ReviewView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 04/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var viewModel: ReviewViewModel
    @State var hotelName: String
    @State var reviewText: String = ""
    @State var lastFullStar = 2
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
                        VStack(alignment: .leading) {
                            StarsView(isEditable: false, lastFullStar: review.rate)
                            HStack {
                                Image(systemName: "person")
                                Text(review.name)
                                Text(": \(review.review)")
                            }.padding()
                        }.padding()
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
