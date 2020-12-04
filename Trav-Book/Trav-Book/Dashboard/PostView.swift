//
//  PostView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct PostView: View {
    var postText: String = ""
    var profileImageString: String = ""
    var profileName: String = ""
    var user = CurrentUser.shared
    let storage = Storage.storage()

    @State var comments: [String] = [String]()
    @State var isCommenting = false
    @State var numberOfLike: Int = 0
    @State var numberOfDislike: Int = 0
    @State var post: PostModel
    @State var image: Image?
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
//                image?
//                    .resizable().frame(height: 200)
                if #available(iOS 14.0, *) {
                    LazyHStack {
                        PageView(image: $image).frame(width: UIScreen.main.bounds.width - 40 ,height: 200)
                    }
                } else {
                    // Fallback on earlier versions
                }
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
                }.padding(20)
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
//            }
            }.background(Color.gray)
            .cornerRadius(10)
            .onAppear() {
                self.numberOfLike = self.post.numberOfLike ?? 0
                self.numberOfDislike = self.post.numberOfDislike ?? 0
                model.getImage(post: post) { (data) in
                    let uiImage = UIImage(data: data!)
                    image = Image(uiImage: uiImage!)
                }
                //            let image = UIImage(named: "im")
                //            let data = image!.pngData()
                //            let metadata = StorageMetadata()
                //            metadata.contentType = "image/jpeg"
                //
                //            storage.reference().child("test").putData(data!, metadata: metadata) { (meta, error) in
                //                guard let meta = meta else {
                //                    return
                //                }
                //                print("Done")
                //            }
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

struct PageView: View {
    @Binding var image: Image?
    var body: some View {
        if #available(iOS 14.0, *) {
            TabView {
                ForEach(0..<5) { i in
                    ZStack {
                        Color.black
                        image?
                            .resizable().frame(height: 200)
                    }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
            }
            .tabViewStyle(PageTabViewStyle())
        } else {
            // Fallback on earlier versions
        }
    }
}
