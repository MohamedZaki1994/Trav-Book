//
//  TopPlacesView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 27/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct TopPlacesView: View {
    @ObservedObject var viewModel: TopPlacesViewModel = TopPlacesViewModel()

    var body: some View {
        Text(viewModel.dataModel?.first?.email ?? "loading")
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
