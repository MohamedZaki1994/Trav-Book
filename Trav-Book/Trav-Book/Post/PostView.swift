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

@available(iOS 14.0, *)
struct PostView: View {
    var postText: String = ""
    var profileImageString: String = ""
    var profileName: String = ""
    var user = CurrentUser.shared
    let storage = Storage.storage()
    var factory: FactoryManager?

    @State var comments: [Comment] = [Comment]()
    @State private var isCommenting = false
    @State private var numberOfLike: Int = 0
    @State private var numberOfDislike: Int = 0
    @ObservedObject var post: PostModel
    @State var image = [Image?]()
    @State var profileImage: Image?
    @State var showAlert = false
    @State var shouldShowDelete = false
    var action: ((PostModel) -> Void)?
    var postViewModel = PostViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if profileImage != nil {
                    profileImage?.imageIconModifier(width: 60, height: 60)

                } else {
                    Image(systemName: "person")
                }
                Text(self.post.name ?? "")
                if !post.place.isEmpty {
                    Text("in").padding(.leading, 10)
                    Text(post.place)
                        .foregroundColor(.green)
                }
                Spacer()
                Text(self.post.date?.timeAgo() ?? "0.0")
                if shouldShowDelete {
                    Button(action: {
                        showAlert = true
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    }).buttonStyle(BorderlessButtonStyle())
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Delete"), message: Text("Are you sure you want to delete this post"), primaryButton: .destructive(Text("Delete"), action: {
                            postViewModel.deletePost(postId: post.id ?? "")
                        }), secondaryButton: .cancel(Text("No"), action: {
                            print("no")
                        }))
                    })
                }
            } .padding(8)
            Text(post.postText ?? "")
                .padding(.bottom, 10)
                .padding(.leading, 10)
            LazyHStack {
                if !image.isEmpty {
                    image.first??.resizable().frame(width: UIScreen.main.bounds.width - 10, height: 250)
                    //                            PageView(image: $image).frame(width: UIScreen.main.bounds.width - 40 ,height: 200)
                } else {
                    Text("loading")
                }
            }.frame(width: UIScreen.main.bounds.width - 10, height: 250)
            Divider()
            HStack {
                Button(action: {
//                    self.post.numberOfLike! += 1
//                    self.numberOfLike += 1
//                    postViewModel.update(currentPost: self.post, like: true)
//                    self.action?(self.post)
//                    if let url = URL(string:UIApplication.openSettingsURLString) {
                    let url = URL(string: "Trav-Book://zaki/")!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                    }
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
                NavigationLink(destination: CommentView(postId: post.id ?? "", userId: post.userId ?? ""), isActive: self.$isCommenting) {
                    EmptyView().disabled(true)
                }.disabled(true)
                .buttonStyle(PlainButtonStyle())
                .frame(width: 0, height: 0)
                .hidden()

                Button(action: {
                    self.isCommenting = true

                }) {
                    Text("\((post.numberOfComments ?? 0)) comment").font(.system(size: 14))
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
                        DispatchQueue.main.async {

                            for data in datas {
                                let uiImage = UIImage(data: data!)
                                image.append(Image(uiImage: uiImage!))
                            }
                        }
                        profileImage = Image(uiImage: UIImage(data: profileData)!)
                    }
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
