//
//  TopPlacesView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 27/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TopPlacesView: View {
    @ObservedObject var viewModel: TopPlacesViewModel

    init(viewModel: TopPlacesViewModel, factory: FactoryManager){
        self.viewModel = viewModel
        self.factory = factory
      }
    var factory: FactoryManager?
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
        NavigationView {
            List {
                Section(header: SearchView()
                            .background(Color.gray)
                            .listRowInsets(EdgeInsets(
                                            top: 0,
                                            leading: 0,
                                            bottom: 0,
                                            trailing: 0)).animation(.easeInOut(duration: 0.3))
                ) {
                switch viewModel.status {
                case .initial:
                    Text("").onAppear() {
                        viewModel.getData()
                    }
                case .loading:
                    Text("loading")
                case .finished:
                    ForEach(viewModel.dataModel!, id: \.self.id) { place in
                        HStack {
                            factory?.makePlaceCardView(model: place)
                        }.listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    }
                case .failure(error: let error):
                    Text(error.debugDescription)
                }
                }.textCase(nil)
            }.listStyle(PlainListStyle())
            .navigationBarHidden(true)
            .background(Color.gray)
        }.padding(.top, 1)
        .background(Color.gray)
        }.background(Color.gray)
    }

//    func makePlaceCardView(model: TopPlacesModel) -> some View {
//        let viewModel = PlaceCardViewModel()
//        viewModel.dataModel = model
//        return PlaceCardView(viewModel: viewModel)
//    }
}


//struct TopPlacesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopPlacesView()
//    }
//}
