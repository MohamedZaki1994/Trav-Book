//
//  CommentView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 10/10/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct CommentView: View {
    @State var comment = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = CommentViewModel()
    @State var image: Image?
    var postId: String
    var userId: String
    var body: some View {
        VStack {
            switch viewModel.status {
            case .initial:
                Text("").onAppear() {
                    viewModel.status = .finished
                }
            case .loading:
                Text("").onAppear() {
                    viewModel.loadComments(userId: postId)
                }
            case .finished:
                if (viewModel.commentModel.isEmpty ) {
                    Text("No comments yet")
                } else {
                    ForEach(viewModel.commentModel, id: \.id) { comment in
                        SingleCommentView(comment: comment, numberOfComments: viewModel.commentModel.count, status: viewModel.status)
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                TextField("your comment...", text: $comment).lineLimit(0)

                HStack {
                    Button("Done") {
                        viewModel.uploadComment(postId: postId, userId: userId, comment: comment)
                        comment = ""
                    }
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }.padding()
                }
            case .failure(error: let error):
                Text(error.debugDescription)
            }
        }.navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            viewModel.loadComments(userId: postId)
        }
    }
}
