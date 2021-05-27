//
//  DashboardView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Combine

struct DashboardView: View {

    @ObservedObject var viewModel: DashboardViewModel
    @State private var isAlert = false
    @State var indexSet: IndexSet?
    @State var refresh = false
    @Binding var refreshing: Bool

    var body: some View {
        return
            NavigationView {
            List {
//
//                if self.viewModel.isLoading || self.refreshing{
//                    Text("loading")
                if self.viewModel.isLoading {
                    Text("loading")
                } else {
                    UploadPost(onDismiss: {
                        refresh = true
                    })
                        .environmentObject(self.viewModel)
                    ForEach(viewModel.posts.reversed()) { post in
                        if #available(iOS 14.0, *) {
                            PostView(comments: post.comments ?? [""], post: post, refreshPost: $refresh)
                                .onTapGesture {}
                                .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
                        } else {
                            // Fallback on earlier versions
                        }

                    }
                    .onAppear(){
                        viewModel.isLoading = false
                    }
                }
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
//            .environment(\.defaultMinListRowHeight, 100)
            .onAppear() {
//                if !self.viewModel.posts.isEmpty {
//                    self.viewModel.refresh()
//                } else {
//                    self.viewModel.isLoading = true
//                }
                viewModel.getData()
                viewModel.isLoading = true
        }
            .navigationBarHidden(true)
//    .navigationBarHidden(false)
            }
    }
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView(viewModel: DashboardViewModel())
//        //        DashboardView(isRefresh: Binding.constant(false))
//    }
//}
