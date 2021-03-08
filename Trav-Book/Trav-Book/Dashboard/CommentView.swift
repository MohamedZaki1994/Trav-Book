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
//    @Binding var isCommenting: Bool
    @State var shouldRefresh: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: DashboardViewModel
    @StateObject var post: PostModel
    var commentAction: ((String) -> Void)?
    var body: some View {
        VStack {
            if !shouldRefresh {
                if (post.comments?.count == 1) {

                } else {
                    ForEach(post.comments!, id: \.self) { comment in
                        HStack {
                            Text(comment)
                            Spacer()
                        }
                    }
                    Spacer()
                }
                TextField("your comment...", text: $comment).lineLimit(0)

                HStack {
                    Button("Done") {
                        self.model.comment(currentPost: post, comment: comment)
                        shouldRefresh.toggle()
                        shouldRefresh.toggle()
                        comment = ""
                    }
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            //            else if (isCommenting && index == comments.count - 1){
            //
            //                TextField("your comment...", text: $comment).lineLimit(0)
            //                HStack {
            //                        Button("Done") {
            //                            self.comments.removeLast()
            //                            self.commentAction?(self.comment)
            //                        }.buttonStyle(PrimaryButtonStyle())
            //                        .padding()
            //
            //                        Button("Cancel") {
            //                            self.comment = ""
            //                            self.comments.removeLast()
            //                            isCommenting = false
            //                        }.buttonStyle(PrimaryButtonStyle())
            //                        .background(Color.red)
            //                        .padding()
            //                    }
            //            }
            //            else if (index != comments.count){
            //                Text((comments[index ?? 0]))
            //                    .padding(5)
            //                    .background(Color(red: 220/255, green: 220/255, blue: 220/255))
            //                    .cornerRadius(5)
            //                    .padding(5)
            //            }
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
