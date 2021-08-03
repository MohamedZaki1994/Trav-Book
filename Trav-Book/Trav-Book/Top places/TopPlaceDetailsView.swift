//
//  TopPlaceDetailsView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct TopPlaceDetailsView: View {
    @ObservedObject var viewModel: TopPlaceDetailsViewModel
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack {
                switch viewModel.status {
                case .finished:
                    ScrollView {
                        TopPlaceDetailsInfoView(viewModel: viewModel)
                    }
                case .loading:
                    Text("loading")
                case .initial:
                    Text("")
                case .failure(error: let error):
                    Text(error.debugDescription)
                }
            }.navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(viewModel.name ?? "")
            .onAppear() {
                viewModel.getData()
            }
        } else {}
    }
}
