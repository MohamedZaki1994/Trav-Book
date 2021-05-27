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
    @State var shouldRefresh: Bool = false
    @Environment(\.presentationMode) var presentationMode
    var postviewmodel = PostViewModel()
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
                        postviewmodel.comment(currentPost: post, comment: comment)
                        shouldRefresh.toggle()
                        shouldRefresh.toggle()
                        comment = ""
                    }
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
