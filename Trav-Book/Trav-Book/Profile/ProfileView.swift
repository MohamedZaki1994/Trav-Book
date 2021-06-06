//
//  ProfileView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 9/19/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Firebase

@available(iOS 14.0, *)
struct ProfileView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    @State private var isEditting = false
    @State private var inputImage: UIImage?
    @State var showingImagePicker = false
    @StateObject var object = CurrentUser.shared
    @State var refresh = false
    @ObservedObject var viewModel: DashboardViewModel
    @State var name: String = ""
    @State var birthday: String = ""
    @State var region: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Group {
                    if object.profileImage != nil {
                        object.profileImage?.resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    } else {
                        Image(systemName: "person")
                    }
                }.onTapGesture {
                    showingImagePicker = true
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
                }
                HStack{
                    Text("Name:").bold()
                    TextField(CurrentUser.shared.name ?? "" + ":", text: $name).disabled(!self.isEditting)
                }
                Divider()
                HStack{
                    Text("Birthday:").bold()
                    TextField(CurrentUser.shared.birthDate ?? "" + ":", text: $birthday).disabled(!self.isEditting)
                    
                }
                Divider()
                HStack{
                    Text("Region:").bold()
                    TextField(CurrentUser.shared.region ?? "" + ":", text: $region).disabled(!self.isEditting)
                }
                HStack {
                    if isEditting {
                        Button("cancel") {
                            self.isEditting = false
                            name = CurrentUser.shared.name ?? ""
                            birthday = CurrentUser.shared.birthDate ?? ""
                            region = CurrentUser.shared.region ?? ""
                        }}
                    Button(isEditting ? "Save" : "Edit") {
                        self.isEditting.toggle()
                        CurrentUser.shared.name = name
                        CurrentUser.shared.birthDate = birthday
                        CurrentUser.shared.region = region
                        CurrentUser.shared.updateUserInfo()
                    }
                }
                Button(action: {
                    AuthProvider.shared.signOut()
                } ){
                    Text("Logout")
                }
                List {
                    if profileViewModel.posts.isEmpty {
                        Text("Loading...")
                    } else {
                        
                        ForEach(profileViewModel.posts.reversed()) { post in
                            if #available(iOS 14.0, *) {
                                PostView(comments: post.comments ?? [""], post: post, refreshPost: $refresh)
                                    .onTapGesture {}
                                    .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
                            } else {
                                // Fallback on earlier versions
                            }
                            
                        }
                    }
                }
                .onAppear() {
                    name = CurrentUser.shared.name ?? ""
                    birthday = CurrentUser.shared.birthDate ?? ""
                    region = CurrentUser.shared.region ?? ""
                    profileViewModel.loadUserPosts()
                }
                .onDisappear() {
                    print("finished")
                }
            }
        }

    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        CurrentUser.shared.profileImage = Image(uiImage: inputImage)
        AuthProvider.shared.updateProfileImage(image: inputImage, completion: nil)
    }
}
