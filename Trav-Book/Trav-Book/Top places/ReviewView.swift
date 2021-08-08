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
    var body: some View {
        List {
            if let reviews = viewModel.hotelReviews {
                ForEach(reviews, id: \.id) { review in
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
        StarsView(isEditable: true, lastFullStar: 2)
        TextField("write a review", text: $reviewText).padding()
        .onAppear() {
            viewModel.fetchReviews(hotelName: hotelName)
        }
    }
}
