//
//  PostView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct PostView: View {
   var postText: String = ""
    var profileImageString: String = ""
    var profileName: String = ""
    var user = CurrentUser.shared
    @State var comments: [String] = [String]()
    @State var isCommenting = false
    @State var numberOfLike: Int = 0
    @State var numberOfDislike: Int = 0
    @State var post: PostModel
    var action: ((PostModel) -> Void)?
     @EnvironmentObject var model: DashboardViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                Text(self.post.name ?? "")
            } .padding(10)
            Text(post.postText ?? "")
                .padding()
            Image("im")
                .resizable()
                .padding()
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
                .padding(10)
                .background(Color.blue)
                .cornerRadius(20)
                .buttonStyle(PrimaryButtonStyle())

                Spacer()
                Button(action: {
                    print("dislike")
                    self.post.numberOfDislike! += 1
                    self.numberOfDislike += 1
                    self.model.update(numberOfLikes: self.post, like: false)
                               }) {
                                Text("\(self.numberOfDislike) dislike")}
                .padding(10)
                .background(Color.blue)
                .cornerRadius(20)
                .buttonStyle(PrimaryButtonStyle())
                Spacer()
                Button(action: {
                    self.comments.append("1")
                    self.isCommenting = true

                    print("comment")
                }) {
                    Text("comment")

                }.buttonStyle(PrimaryButtonStyle())
                .padding(10)
                .background(Color.blue)
                .cornerRadius(20)
            }.padding()

            ForEach(0 ..< comments.count, id: \.self) { index in
                //                CommentView(comment: "", comments: self.$comments, flag: self.$isCommenting, isCommented: true, index: index)
                CommentView(comment: "", comments: self.$comments, isCommenting: self.$isCommenting, index: index)
                { (text) in
                    if text == "" {
                    } else {
                       let wholeText = "\(user.name ?? ""): \(text)"
                        self.post.comments?.append(wholeText)
                        self.comments.append(wholeText)
                        self.model.update(numberOfLikes: self.post, like: nil)
                    }
                    self.isCommenting = false
                }
            }

        }.background(Color.gray)
        .cornerRadius(10)
        .onAppear() {
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
