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
//                if self.viewModel.isLoading {
//                    Text("loading")
//                } else {
//                    UploadPost(onDismiss: {
//                        refresh = true
//                    })
//                        .environmentObject(self.viewModel)
//                    ForEach(viewModel.posts.reversed()) { post in
//                        if #available(iOS 14.0, *) {
//                            PostView(comments: post.comments ?? [""], post: post, refreshPost: $refresh)
//                                .onTapGesture {}
//                                .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
//                        } else {
//                            // Fallback on earlier versions
//                        }
//
//                    }
//                    .onAppear(){
//                        viewModel.isLoading = false
//                    }
//                }
//                        .onAppear() {
//                            self.viewModel.getData()
//                            self.refreshing = false
//                        }
//                        .navigationBarHidden(false)
//
//
//                } else {
//                    if !viewModel.posts.isEmpty {
//                        ForEach(viewModel.posts.reversed()) { post in
//
//                            Section {
//                                //                            PostView(postText: post.postText ?? "", profileImageString: post.name ?? "", profileName: post.name ?? "", comments: post.comments ?? [""], numberOfLike: post.numberOfLike ?? 0, numberOfDislike: post.numberOfDislike ?? 0 ,post: post).environmentObject(self.viewModel)
//                                PostView(comments: post.comments ?? [""], post: post).environmentObject(self.viewModel)
//                                    .navigationBarHidden(false)
//                            }
//                        }
//                        .alert(isPresented: self.$isAlert) { () -> Alert in
//                            Alert(title: Text("Warning"), message: Text("Are you sure"), primaryButton: .default(Text("Sure"), action: {
//                                self.viewModel.posts.remove(atOffsets: self.indexSet!)
//                                print("Done")
//                            }), secondaryButton: .cancel())
//                        }
//                    }
//                }
//                Spacer()
            }
//            .onAppear() {
//                viewModel.getData()
//        }
            .navigationBarHidden(true)
            }
    }
}
