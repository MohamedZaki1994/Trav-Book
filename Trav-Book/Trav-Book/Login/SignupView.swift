//
//  SignupView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 9/29/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct SignupView: View {
    @Binding var isSignup: Bool
    @State var username = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State private var birthDate = Date()
    var isMatched: Bool {
        return password == confirmPassword
    }
    var body: some View {
        Form {
            VStack {
                Text("Enter your username")
                TextField("username", text: $username)
            }
            VStack {
                Text("Enter your password")
                TextField("password", text: $password)
            }
            VStack {
                Text("Confirm your username")
                TextField("password", text: $confirmPassword).foregroundColor(isMatched ? Color.black : Color.red )
            }
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                           Text("Select your birthdate")
                       }
            Button("Done") {
                AuthProvider.shared.createAccount(email: self.username, password: self.password,birthDate: "", image: "") { (error) in
                    if error == nil {
                        self.isSignup = false
                    }
                }

            }
        }
    }
}

//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView()
//    }
//}
