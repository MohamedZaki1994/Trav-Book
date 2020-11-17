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

                TextField("your comment...", text: $comment).lineLimit(0)
                HStack {
                        Button("Done") {
                            self.comments.removeLast()
                            self.commentAction?(self.comment)
                        }.buttonStyle(PrimaryButtonStyle())
                        .padding()

                        Button("Cancel") {
                            self.comment = ""
                            self.comments.removeLast()
                            isCommenting = false
                        }.buttonStyle(PrimaryButtonStyle())
                        .background(Color.red)
                        .padding()
                    }
            }
            else if (index != comments.count){
                Text((comments[index ?? 0]))
                    .background(Color.init(red: 211, green: 211, blue: 211))
                    .cornerRadius(5)
                    .padding(5)
            }
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
