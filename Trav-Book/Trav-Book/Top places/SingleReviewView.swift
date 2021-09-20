//
//  SingleReviewView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 30/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct SingleReviewView: View {
    var review: HotelReviewModel
    @StateObject var viewModel = SingleReviewViewModel()
    @State var image: Image?
    var body: some View {
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
                Spacer()
                Text(review.date.timeAgo()).font(.system(size: 14))
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
