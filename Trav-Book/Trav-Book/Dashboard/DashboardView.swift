//
//  DashboardView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Combine

@available(iOS 14.0, *)
struct DashboardView: View {

    @ObservedObject var viewModel: DashboardViewModel
    @State private var isAlert = false
    @State var indexSet: IndexSet?
    var factory: FactoryManager?

    var body: some View {
        return
            NavigationView {
            List {
                switch viewModel.status {
                case .initial:
                    Text("").onAppear() {
                        viewModel.getData()
                    }
                case .loading:
                    Text("").onAppear() {
                        viewModel.getData()
                    }
                case .finished:
                    UploadPost(onDismiss: {
                        viewModel.status = .loading
                    })
                    .environmentObject(self.viewModel)
                    ForEach(viewModel.posts.reversed()) { post in
                        PostView(factory: factory, post: post)
                            .onTapGesture {}
                            .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
                        
                    }
                case .failure(error: let error):
                    Text(error.debugDescription)
                }
            }
            .navigationBarHidden(true)
            }
    }
}
