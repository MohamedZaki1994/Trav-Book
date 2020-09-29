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
    var body: some View {
        VStack {
            Text("Enter your username")
            TextField("username", text: $username)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button("Done") {
                self.isSignup = false
            }
        }
    }
}

//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView()
//    }
//}
