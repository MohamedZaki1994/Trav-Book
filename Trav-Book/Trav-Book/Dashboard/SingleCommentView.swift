//
//  SingleCommentView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 13/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct SingleCommentView: View {
    var comment: Comment
    @State var numberOfComments = 0
    @State var image: Image?
    @State var shouldShowDelete = true
    @State var shouldShowAlert = false
    var viewModel = SingleCommentViewModel()
    var postId = ""
    var body: some View {
        HStack {
            if image != nil {
                image?.imageIconModifier(width: 50, height: 50)
            } else {
                Image(systemName: "person.fill")
            }
            Text("\(comment.name): \(comment.text)")
            Spacer()
            Text("Date")
            Button(action: {
                shouldShowAlert = true
            }, label: {
                Image(systemName: "xmark.circle.fill")
            })
            .alert(isPresented: $shouldShowAlert, content: {
                Alert(title: Text("Delete"), message: Text("Are you sure you want delete this comment"), primaryButton: .destructive(Text("Yes"), action: {
                    viewModel.deleteComment(comment: comment, numberOfComments: numberOfComments)
                }), secondaryButton: .cancel())
            })
        }.onAppear() {
            viewModel.loadImage(userId: comment.ownerId) { (data) in
                guard let uiImage = UIImage(data: data) else {return}
                image = Image(uiImage: uiImage)
            }
        }
    }
}
