//
//  PlaceCardView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 30/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct PlaceCardView: View {
    @State var rating: Rating?
    @ObservedObject var viewModel: PlaceCardViewModel
    @State var image: Image?
    @State var uiImage: UIImage?
    @State private var shouldGoToDetailsView = false
    var factory: FactoryManager?
    var body: some View {
        VStack(alignment: .center) {
            if image != nil {
                image?.resizable().frame(height: 200)
                    .cornerRadius(5)
            } else {
                Image(systemName: "house.fill")
            }
            Text(viewModel.dataModel?.name ?? "").font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.blue)

            VStack(alignment: .leading) {
                HStack {
                    Text("place: \(viewModel.dataModel?.region ?? "")").font(.system(size: 15))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(viewModel.rating) / 5")
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
                Text("email: \(viewModel.dataModel?.email ?? "")")
                Text("costs: \(viewModel.dataModel?.price ?? 0)$")
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.green)
                NavigationLink("", destination: factory?.makeTopPlaceDetailsView(name: viewModel.dataModel?.name ?? "", image: uiImage, rate: viewModel.dataModel?.rating), isActive: $shouldGoToDetailsView)
                    .hidden()
            }
        }
        .onAppear() {
            rating = viewModel.getRating(ratingNumber: viewModel.dataModel?.rating ?? 0)
            if image == nil {
                viewModel.getImage(id: (viewModel.dataModel?.name)!) { (uiimage) in
                    self.image = Image(uiImage: uiimage)
                    self.uiImage = uiimage
                }
            }
        }
        .onTapGesture {
            if image != nil {
                shouldGoToDetailsView = true
            }
        }
    }
}

//struct PlaceCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceCardView()
//    }
//}
