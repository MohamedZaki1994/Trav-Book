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
                        VStack(alignment: .leading) {
                            StarsView(isEditable: false, lastFullStar: review.rate)
                            HStack {
                                if image != nil {
                                    image?.imageIconModifier(width: 80, height: 80)
                                } else {
                                    Image("im").imageIconModifier(width: 80, height: 80)
                                }
                                Text(review.name)
                                Text(": \(review.review)")
                            }
                            .onAppear() {
                                viewModel.loadImage(userId: review.userId) { (data) in
                                    guard let uiImage = UIImage(data: data) else {return}
                                    image = Image(uiImage: uiImage)
                                }
                            }
                            .padding()
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
