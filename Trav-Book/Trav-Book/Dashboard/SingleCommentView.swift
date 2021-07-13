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
    @State var image: Image?
    var viewModel = SingleCommentViewModel()
    var body: some View {
        HStack {
            if image != nil {
                image?.imageIconModifier(width: 50, height: 50)
            } else {
                Image(systemName: "person.fill")
            }
            Text("\(comment.name): \(comment.text)")
            Spacer()
        }.onAppear() {
            viewModel.loadImage(userId: comment.id) { (data) in
                guard let uiImage = UIImage(data: data) else {return}
                image = Image(uiImage: uiImage)
            }
        }
    }
}
