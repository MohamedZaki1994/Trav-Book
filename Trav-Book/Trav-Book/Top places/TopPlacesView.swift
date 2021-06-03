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
        VStack(spacing: 30) {
            if !(viewModel.dataModel?.isEmpty ?? true) {
                ForEach(viewModel.dataModel!, id: \.self.id) { place in
                    HStack {
                        PlaceCardView(viewModel: place )
                    }
                }
            }
            Spacer()
        }
            .onAppear(){
                viewModel.getData()
            }
    }
}


//struct TopPlacesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopPlacesView()
//    }
//}
