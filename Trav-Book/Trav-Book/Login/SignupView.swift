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
    @State var name = ""
    @State var country = ""
    @State private var birthDate = Date()
    @State private var isPresented = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?

    var viewmodel = SignupViewmodel()
    var isMatched: Bool {
        return password == confirmPassword
    }

    var body: some View {
        Form {
            VStack {
                Text("Enter your name")
                TextField("name", text: $name)
            }
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
            VStack {
                Text("Enter your country")
                TextField("country", text: $country)
            }
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Select your birthdate")
            }
            HStack {
                Spacer()
                if image == nil {
                    Image(systemName: "person")
                } else {
                    image?.resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                        .padding()

                }
                Spacer()
            }.onTapGesture {
                isPresented = true
            }
            .sheet(isPresented: $isPresented, onDismiss: { }, content: {
//                if refresh {
//                    Text("refreshing").onAppear(){
//                        refresh = false
//                    }
//                }
//                else {

            HStack(spacing: 20) {
                Button {
                    print("uploading")
                    self.showingImagePicker = true
                } label: {
                    Text("upload a photo")
                }
                Button {
                    print("take")
                } label: {
                    Text("take a photo")
                }
                Button {
                    isPresented = false
                } label: {
                    Text("Done")
                }

        }
            .sheet(isPresented: $showingImagePicker, onDismiss: {
                guard let inputImage = inputImage else { return }
                image = Image(uiImage: inputImage)
            }) {
                ImagePicker(image: self.$inputImage)
        }
            Spacer()
//            }
        })

            Button("Done") {
                if self.isMatched {
                    self.viewmodel.signup(name: self.name, email: self.username, password: self.password, birthdate: self.birthDate, country: self.country, image: inputImage) { (success) in
                        if success {
                            self.isSignup = false
                        }
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
