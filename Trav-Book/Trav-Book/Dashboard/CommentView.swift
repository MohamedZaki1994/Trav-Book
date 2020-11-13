//
//  CommentView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 10/10/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct CommentView: View {
    @State var comment = ""
    @Binding var comments: [String]
    @Binding var isCommenting: Bool
    @State var index: Int?
    var commentAction: ((String) -> Void)?
    var body: some View {
        VStack {
            if (index == 0) {
                Text("")
            } else if (isCommenting && index == comments.count - 1){

//            if (index != comments.count && !comments[index ?? 0].isEmpty && comments[index ?? 0] != "1") {
//                Text(comments[index ?? 0])
//            } else if (comments.count > 1 && !comments[index ?? 0].isEmpty){
//                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                TextField("your comment...", text: $comment).lineLimit(0)
                HStack {
                        Button("Done") {
                            self.comments.removeLast()
                            self.commentAction?(self.comment)
                        }.buttonStyle(PrimaryButtonStyle())
                        Button("Cancel") {
                            self.comment = ""
                            self.comments.removeLast()
                            isCommenting = false
                        }.buttonStyle(PrimaryButtonStyle())
                    }
//            } else {
//                Text("")
            }
            else if (index != comments.count){
                Text(comments[index ?? 0])
            }
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
