//
//  DashboardView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct DashboardView: View {

    @ObservedObject var viewModel: DashboardViewModel = DashboardViewModel()
    @State private var isAlert = false
    @State var indexSet: IndexSet?
    var body: some View {
        let posts = viewModel.posts
        return
//            ScrollView {
//                GeometryReader { geo in
                List {
                    if self.viewModel.isLoading {
                        Text("loading")
                    } else {
                        Text("Hello world")
                        ForEach(posts) { post in
                            Section {
                                PostView(postText: post.postText ?? "", profileImageString: post.imageName ?? "", profileName: post.name ?? "")
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
                }.environment(\.defaultMinListRowHeight, 100)
                    .onAppear() {
                        self.viewModel.isLoading = true
                        self.viewModel.getData()
//                }.frame(width: geo.size.width)
//                }
        }

    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        //        DashboardView(viewModel: DashboardViewModel())
        DashboardView()
    }
}
