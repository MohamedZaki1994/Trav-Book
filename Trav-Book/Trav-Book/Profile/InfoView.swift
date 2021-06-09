//
//  InfoView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 06/06/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @Binding var name: String
    @Binding var birthday: String
    @Binding var region: String
    @Binding var isEditting: Bool
    var body: some View {
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
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoView()
//    }
//}