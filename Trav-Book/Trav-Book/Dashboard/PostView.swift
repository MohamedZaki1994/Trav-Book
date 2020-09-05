//
//  PostView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct PostView: View {
    @State var postText: String = "text"
    @State var profileImageString: String = ""
    @State var profileName: String = "Zaki"
    @State var numberOfLike: Int = 0
    @State var post: PostModel
    var action: ((PostModel) -> Void)?
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
//                    self.numberOfLike += 1
                    self.post.numberOfLike! += 1
                    self.action?(self.post)
                    print("like")
                }) {
                    Text("\(self.post.numberOfLike ?? 0) like")}
                        .buttonStyle(PrimaryButtonStyle())

                Spacer()
                Button(action: {
                                   print("dislike")
                               }) {
                                   Text("dislike")}
                                       .buttonStyle(PrimaryButtonStyle())
                //
//                }
                Spacer()
                Button(action: {
                    print("fsdf")
                }) {
                    Text("comment")

                }.buttonStyle(PrimaryButtonStyle())
//                Spacer()
//                Button(action: {
//                    print("asgfa")
//                }) {
//                    Text("add to favorite")
//
//                }
            }.padding()
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
