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
//    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var instanceProfile = ProfileViewModel()
    @State private var isEditting = false
    @State private var inputImage: UIImage?
    @State var showingImagePicker = false
    @StateObject var object = CurrentUser.shared
    var body: some View {
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
                TextField(CurrentUser.shared.name ?? "" + ":", text: self.$instanceProfile.profileModel.name).disabled(!self.isEditting)
            }
            Divider()
            HStack{
                Text("Birthday:").bold()
                TextField(CurrentUser.shared.birthDate ?? "" + ":", text: self.$instanceProfile.profileModel.birthday).disabled(!self.isEditting)

            }
            Divider()
            HStack{
                Text("Region:").bold()
                TextField(CurrentUser.shared.region ?? "" + ":", text: self.$instanceProfile.profileModel.region).disabled(!self.isEditting)
            }
            HStack {
                if isEditting {
                    Button("cancel") {
                        self.isEditting = false
                        self.instanceProfile.profileModel.name = CurrentUser.shared.name ?? ""
                        self.instanceProfile.profileModel.birthday = CurrentUser.shared.birthDate ?? ""
                        self.instanceProfile.profileModel.region = CurrentUser.shared.region ?? ""
                    }}
                Button(isEditting ? "Save" : "Edit") {
                    self.isEditting.toggle()
                    CurrentUser.shared.name = self.instanceProfile.profileModel.name
                    CurrentUser.shared.birthDate = self.instanceProfile.profileModel.birthday
                    CurrentUser.shared.region = self.instanceProfile.profileModel.region
                    CurrentUser.shared.updateUserInfo()
                }
            }
            Button(action: {
                AuthProvider.shared.signOut()
            } ){
                Text("Logout")
            }
            Spacer()
        }

        .onAppear() {
            self.instanceProfile.profileModel.name = CurrentUser.shared.name ?? ""
            self.instanceProfile.profileModel.birthday = CurrentUser.shared.birthDate ?? ""
            self.instanceProfile.profileModel.region = CurrentUser.shared.region ?? ""
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        CurrentUser.shared.profileImage = Image(uiImage: inputImage)
        AuthProvider.shared.updateProfileImage(image: inputImage, completion: nil)
    }
}
