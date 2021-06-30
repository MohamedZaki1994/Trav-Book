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
    @State private var isCommenting = false
    @State private var numberOfLike: Int = 0
    @State private var numberOfDislike: Int = 0
    @State var post: PostModel
    @State var image = [Image?]()
    @State var profileImage: Image?
    @Binding var refreshPost: Bool
    var action: ((PostModel) -> Void)?
    var postViewModel = PostViewModel()
    var body: some View {
        if refreshPost {
            Text("").onAppear(){ refreshPost = false}
        } else {
            VStack(alignment: .leading) {
                HStack {
                    if profileImage != nil {
                        profileImage?.resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)

                    } else {
                        Image(systemName: "person")
                    }
                    Text(self.post.name ?? "")
                    Text("in").padding(.leading, 10)
                    Text(post.place)
                        .foregroundColor(.green)
                    Spacer()
                    Text(self.post.date?.timeAgo() ?? "0.0")
                } .padding(8)
                Text(post.postText ?? "")
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                if #available(iOS 14.0, *) {
                    LazyHStack {
                        if !image.isEmpty {
                            image.first??.resizable().frame(width: UIScreen.main.bounds.width - 10, height: 250)
//                            PageView(image: $image).frame(width: UIScreen.main.bounds.width - 40 ,height: 200)
                        } else {
                            Text("loading")
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
                Divider()
                HStack {
                    Button(action: {
                        self.post.numberOfLike! += 1
                        self.numberOfLike += 1
                        postViewModel.update(currentPost: self.post, like: true)
                        self.action?(self.post)
                    }) {
                        Text("\(self.numberOfLike) like").font(.system(size: 14))}
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .buttonStyle(PrimaryButtonStyle())
                    Spacer()
                    Button(action: {
                        self.post.numberOfDislike! += 1
                        self.numberOfDislike += 1
                        postViewModel.update(currentPost: self.post, like: false)
                    }) {
                        Text("\(self.numberOfDislike) dislike").font(.system(size: 14))}
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .buttonStyle(PrimaryButtonStyle())
                    Spacer()
                    if #available(iOS 14.0, *) {
                        NavigationLink(destination: CommentView(post: post), isActive: self.$isCommenting) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0, height: 0)
                        .hidden()
                    } else {
                        // Fallback on earlier versions
                    }
                    Button(action: {
                        self.isCommenting = true

                    }) {
                        Text("\((post.comments?.count ?? 0) - 1) comment").font(.system(size: 14))
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(20)
                }.padding(10)
            }
            .background(Color(red: 211/255, green: 211/255, blue: 211/255))
            .cornerRadius(10)
            .onAppear() {
                self.numberOfLike = self.post.numberOfLike ?? 0
                self.numberOfDislike = self.post.numberOfDislike ?? 0
                if image.isEmpty {
                postViewModel.getImage(post: post) { (datas, profileData) in
                    if let datas = datas {
                        for data in datas {
                            let uiImage = UIImage(data: data!)
                            image.append(Image(uiImage: uiImage!))
                        }
                    }
                    profileImage = Image(uiImage: UIImage(data: profileData)!)
                }
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
    @Binding var image: [Image?]
    var body: some View {
        if #available(iOS 14.0, *) {
            TabView {
                Text("S")
//                ForEach(0 ..< image.count) { im in
//                    ZStack {
//                        Color.black
//                        if image.count > 0 {
//                        image[im]?
//                            .resizable().frame(height: 200)
//                        }
//                    }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
//                }
            }
            .tabViewStyle(PageTabViewStyle())
        } else {
            // Fallback on earlier versions
        }
    }
}
