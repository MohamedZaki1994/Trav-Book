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
    @Binding var isLoggedIn: Bool
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
            Image(systemName: "person")
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
            Button(action: {
                try? Auth.auth().signOut()
                self.isLoggedIn = true
                self.isNavigation = false
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
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(isNavigation: Binding.constant(true))
//    }
//}
