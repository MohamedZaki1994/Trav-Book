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
        VStack {
            Image("im")
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: 400)
            Text("some description")
        }
    }
}
