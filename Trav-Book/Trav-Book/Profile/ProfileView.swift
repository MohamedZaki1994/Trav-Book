//
//  ProfileView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 9/19/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @Binding var isNavigation: Bool
//    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var instanceProfile = ProfileViewModel()
    @State private var isEditting = false
    var body: some View {
        VStack {
            HStack {
                if isEditting {
                    Button("cancel") {
                        self.isEditting = false
                        self.instanceProfile.profileModel.name = CurrentUser.shared.name ?? ""
                        self.instanceProfile.profileModel.birthday = CurrentUser.shared.birthDate ?? ""
                        self.instanceProfile.profileModel.region = "Egypt"//self.profileViewModel.profileModel.region
                    }}
                Button(isEditting ? "Save" : "Edit") {
                    self.isEditting.toggle()
                    CurrentUser.shared.name = self.instanceProfile.profileModel.name
                    CurrentUser.shared.birthDate = self.instanceProfile.profileModel.birthday
                    CurrentUser.shared.updateUserInfo()
//                    self.profileViewModel.profileModel.name = self.instanceProfile.profileModel.name
//                    self.profileViewModel.profileModel.birthday = self.instanceProfile.profileModel.birthday
//                    self.profileViewModel.profileModel.region = self.instanceProfile.profileModel.region

                }
            }
            Image(systemName: "person")
            HStack{
                Text("Name:").bold()
                TextField("Zaki", text: self.$instanceProfile.profileModel.name).disabled(!self.isEditting)

            }
            Divider()
            HStack{
                Text("Birthday:").bold()
                TextField("12-9-1994", text: self.$instanceProfile.profileModel.birthday).disabled(!self.isEditting)

            }
            Divider()
            HStack{
                Text("Region:").bold()
                TextField("Egypt", text: self.$instanceProfile.profileModel.region).disabled(!self.isEditting)
            }
            Button(action: {
                try? Auth.auth().signOut()
                self.isNavigation = false
            } ){
                Text("Logout")
            }
            Spacer()
        }

//        .navigationBarHidden(true)
//        .navigationBarTitle("")
//        .navigationBarBackButtonHidden(true)
        .onAppear() {

//            self.profileViewModel.fillProfile()
            self.instanceProfile.profileModel.name = CurrentUser.shared.name ?? ""
            self.instanceProfile.profileModel.birthday = CurrentUser.shared.birthDate ?? ""
            self.instanceProfile.profileModel.region = "Egypt"//self.profileViewModel.profileModel.region

        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(isNavigation: Binding.constant(true))
//    }
//}
