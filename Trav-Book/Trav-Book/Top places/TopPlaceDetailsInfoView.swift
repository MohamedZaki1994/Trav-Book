//
//  TopPlaceDetailsInfoView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 14/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TopPlaceDetailsInfoView: View {
    @ObservedObject var viewModel: TopPlaceDetailsViewModel
    var body: some View {
        LazyVStack(alignment: .leading) {
            Group {
                Image(uiImage: viewModel.image ?? UIImage())
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                Text(viewModel.model?.hotelDescription ?? "").padding()
                Divider()
            }
            Group {
                HStack {
                    Image(systemName: "location.fill")
                    Text("Address: \(viewModel.model?.address ?? "")").padding()
                }.padding()
                Divider()
                HStack {
                    Image(systemName: "envelope")
                    Text("Email: \(viewModel.model?.email ?? "")").padding()
                }.padding()
                Divider()
                HStack {
                    Image(systemName: "person.2.fill")
                    Text("Remaining rooms: \(viewModel.model?.numberOfRooms ?? 0)").padding()
                }.padding()
                Divider()
            }
            Group {
                HStack {
                    Image(systemName: "dollarsign.circle")
                    Text("Price: \(viewModel.model?.price ?? 0)").padding()
                }.padding()
                Divider()
                HStack {
                    Image(systemName: "star.fill")
                    Text("Rating: \(String(format: "%.1f", viewModel.model?.rating ?? 0))").padding()
                }.padding()
                Divider()
            }
            Text("Reviews").font(.system(size: 25)).padding()
            Divider()
            ForEach(viewModel.model?.reviews ?? [""], id: \.self) {
                Text($0).padding()
            }
            NavigationLink("Write a review", destination: ReviewView(viewModel: ReviewViewModel(), hotelName: viewModel.name ?? "")).padding()
        }
    }
}
