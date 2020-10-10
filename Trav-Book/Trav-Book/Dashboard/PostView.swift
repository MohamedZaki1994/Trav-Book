//
//  PostView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct PostView: View {
   var postText: String
    var profileImageString: String
    var profileName: String
    @State var comments = [String]()
    @State var numberOfLike: Int
    @State var numberOfDislike: Int
    @State var post: PostModel
    var action: ((PostModel) -> Void)?
     @EnvironmentObject var model: DashboardViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                Text(profileName)
            }
            Text(postText)
                .background(Color.gray)
            Divider()
            HStack {
                Button(action: {
                    self.post.numberOfLike! += 1
                    self.numberOfLike += 1
                    self.model.update(numberOfLikes: self.post, like: true)

                    self.action?(self.post)
                    print("like")
                }) {
                    Text("\(self.numberOfLike) like")}
                        .buttonStyle(PrimaryButtonStyle())

                Spacer()
                Button(action: {
                                   print("dislike")
                    self.post.numberOfDislike! += 1
                    self.numberOfDislike += 1
                    self.model.update(numberOfLikes: self.post, like: false)
                               }) {
                                   Text("\(self.numberOfDislike) like")}
                                       .buttonStyle(PrimaryButtonStyle())
                Spacer()
                Button(action: {
                    self.comments.append("")
                    print("comment")
                }) {
                    Text("comment")

                }.buttonStyle(PrimaryButtonStyle())

            }.padding()

            ForEach(0 ..< comments.count, id: \.self) { _ in
                CommentView(comments: self.$comments)
//                Text("")
            }

        }.onAppear() {
            self.numberOfLike = self.post.numberOfLike ?? 0
            self.numberOfDislike = self.post.numberOfDislike ?? 0
        }
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}

struct PrimaryButtonStyle: ButtonStyle {
    let height: CGFloat = 30
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .foregroundColor(configuration.isPressed ? Color.red : Color.yellow)
            .background(configuration.isPressed ? Color.black : Color.blue)
            .cornerRadius(.infinity)
    }
}
