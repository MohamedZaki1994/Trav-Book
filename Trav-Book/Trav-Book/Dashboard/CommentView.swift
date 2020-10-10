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
    @State var isCommented = false
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            TextField("your comment...", text: $comment).lineLimit(0)
            HStack {
                if !isCommented {
                    Button("Done") {
                        self.isCommented = true
                    }.buttonStyle(PrimaryButtonStyle())
                    Button("Cancel") {
                        self.comment = ""
                        self.comments.removeLast()
                    }.buttonStyle(PrimaryButtonStyle())
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
