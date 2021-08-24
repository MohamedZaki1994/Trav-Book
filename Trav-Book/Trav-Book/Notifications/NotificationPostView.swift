//
//  NotificationPostView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 11/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct NotificationPostView: View {
    @StateObject var viewModel = NotificationPostViewModel()
    @Binding var selectedPostId: String
    var body: some View {
        VStack {
            if let post = viewModel.post {
                PostView(post: post)
                    .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
            }
            Text("Notification, World!")
        }.onAppear() {
            viewModel.postID = selectedPostId
            viewModel.loadUserPost()
        }
    }
}
