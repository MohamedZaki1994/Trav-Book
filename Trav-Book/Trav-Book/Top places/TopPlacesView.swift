//
//  TopPlacesView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 27/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct TopPlacesView: View {
    @ObservedObject var viewModel: TopPlacesViewModel

    var body: some View {
        List {
            switch viewModel.status {
            case .initial:
                Text("")
            case .loading:
                Text("loading")
            case .finished:
                ForEach(viewModel.dataModel!, id: \.self.id) { place in
                    HStack {
                        makePlaceCardView(model: place)
                    }.listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                }
            case .failure(error: let error):
                Text(error.debugDescription)
            }
        }
        .onAppear(){
            viewModel.getData()
        }
    }

    func makePlaceCardView(model: TopPlacesModel) -> some View {
        let viewModel = PlaceCardViewModel()
        viewModel.dataModel = model
        return PlaceCardView(viewModel: viewModel)
    }
}


//struct TopPlacesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopPlacesView()
//    }
//}
