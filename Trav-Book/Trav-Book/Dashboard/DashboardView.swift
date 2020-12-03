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
    @Binding var refreshing: Bool

    var body: some View {
        return
            List {

                if self.viewModel.isLoading || self.refreshing{
                    Text("loading")
                        .onAppear() {
                            self.viewModel.getData()
                            self.refreshing = false
                    }
                    .navigationBarHidden(false)


                } else {
                    UploadPost().environmentObject(self.viewModel)
                    if !viewModel.posts.isEmpty {
                    ForEach(viewModel.posts.reversed()) { post in

                        Section {
//                            PostView(postText: post.postText ?? "", profileImageString: post.name ?? "", profileName: post.name ?? "", comments: post.comments ?? [""], numberOfLike: post.numberOfLike ?? 0, numberOfDislike: post.numberOfDislike ?? 0 ,post: post).environmentObject(self.viewModel)
                            PostView(comments: post.comments ?? [""], post: post).environmentObject(self.viewModel)
                            .navigationBarHidden(false)


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
                }
                Spacer()
                }
            .environment(\.defaultMinListRowHeight, 100)
            .onAppear() {
                if !self.viewModel.posts.isEmpty {
                    self.viewModel.refresh()
                } else {
                    self.viewModel.isLoading = true
                }
        }
    .navigationBarHidden(false)

    }
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView(viewModel: DashboardViewModel())
//        //        DashboardView(isRefresh: Binding.constant(false))
//    }
//}
