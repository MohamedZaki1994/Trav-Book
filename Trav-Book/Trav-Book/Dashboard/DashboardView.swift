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

    @ObservedObject var viewModel: DashboardViewModel = DashboardViewModel()
    @State private var isAlert = false
    @State var indexSet: IndexSet?
    @Binding var isRefresh: Bool
//    private var switchSubscriber = Set<AnyCancellable>()

    func isRefreshing() {
        if self.isRefresh {
            self.viewModel.refresh()
        }
    }

    func dummyView(post: PostModel) -> some View {
        var postview =  PostView(postText: post.postText ?? "", profileImageString: post.name ?? "", profileName: post.name ?? "", numberOfLike: post.numberOfLike ?? 0,post: post) { updatedPost in
        //                                    self.viewModel.update(numberOfLikes: updatedPost)
                                        }
        postview.post = post
        return postview
    }

    var body: some View {
        return
            NavigationView {

                List {

                    if self.viewModel.isLoading {
                        Text("loading")
                    } else {
                        ForEach(viewModel.posts) { post in
                            Section {
                                self.dummyView(post: post)
//                                 PostView(postText: post.postText ?? "", profileImageString: post.name ?? "", profileName: post.name ?? "", numberOfLike: post.numberOfLike ?? 0,post: post) { updatedPost in
////                                    self.viewModel.update(numberOfLikes: updatedPost)
//                                }
                            }
                        }
                        .onDelete { (index) in
                            self.isAlert = true
                            self.indexSet = index
                        }
                        .alert(isPresented: self.$isAlert) { () -> Alert in
                            Alert(title: Text("Warning"), message: Text("Are you sure"), primaryButton: .default(Text("Sure"), action: {
                                self.viewModel.posts.remove(atOffsets: self.indexSet!)
                                print("Done")
                            }), secondaryButton: .cancel())
                        }
                    }
                    Spacer()
                }
                .environment(\.defaultMinListRowHeight, 100)
                .onAppear() {
                    self.viewModel.isLoading = true
                    print(self.isRefresh)
                    self.viewModel.getData()
//             switchSubscriber =       self.viewModel.$posts.sink(receiveValue: { ([PostModel]) in
//                        print("")
//                    })
                   var key = self.viewModel.$posts.sink { (pos) in
                    print(self.viewModel.switchSubscriber)
                    print("")
                    }.store(in: &self.viewModel.switchSubscriber)
                    if self.isRefresh {
                        self.viewModel.refresh()
                    }
                }
        }

    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        //        DashboardView(viewModel: DashboardViewModel())
        DashboardView(isRefresh: Binding.constant(false))
    }
}
