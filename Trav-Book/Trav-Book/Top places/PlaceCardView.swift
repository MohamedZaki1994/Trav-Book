//
//  PlaceCardView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 30/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct PlaceCardView: View {
    @ObservedObject var viewModel: TopPlacesModel
    @State var rating: Rating?
    var placeViewModel = PlaceCardViewModel()
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "house.fill")
            Text(viewModel.name ?? "").font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.blue)

            VStack(alignment: .leading) {
                HStack {
                    Text("place: \(viewModel.region ?? "")").font(.system(size: 15))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(String(format: "%.1f", viewModel.rating ?? 0)) / 10")
                        switch rating {
                        case .none, .bad:
                            Image(systemName: "star")
                                .font(.system(size: 12, weight: .bold))
                        case .excellent:
                            Image(systemName: "star.fill")
                                .font(.system(size: 12, weight: .bold))
                        case .good:
                            Image(systemName: "star.lefthalf.fill")
                                .font(.system(size: 12, weight: .bold))
                        }
                    }
                }
                Text("email: \(viewModel.email ?? "")")
                Text("costs: \(viewModel.price ?? 0)$")
                Text("reviews \(viewModel.reviews ?? 0)")
            }
        } .padding()
        .onAppear() {
           rating = placeViewModel.getRating(ratingNumber: viewModel.rating ?? 0)
        }
    }
}

//struct PlaceCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceCardView()
//    }
//}
