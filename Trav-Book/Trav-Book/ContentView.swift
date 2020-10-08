//
//  ContentView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/21/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var isNavigate = false
    @State var isAlert = false
    @State var username = ""
    @State var password = ""
    @State var isSignup = false
    
    var body: some View {
        NavigationView {
            VStack {
                LoginView(username: $username, password: $password)
                    .padding(.leading,10)
                    .padding(.top,50)
                    .frame(height: 150)
                NavigationLink(destination: BaseTabView(isNavigation: $isNavigate) ,isActive: $isNavigate) {
                    Text("")
                }

                HStack(spacing: 50) {
                    Button("Login") {
                        if !self.username.isEmpty, !self.password.isEmpty {
                            Auth.auth().signIn(withEmail: self.username, password: self.password, completion: { (result, error) in
                                guard let result = result else {return}
                                result.user.email
                                if error == nil {
                                    self.isNavigate = true
                                }
                            })
                        } else {
                            self.isAlert = true
                        }
                    }
                    Button("sign up") {
                        self.isSignup = true
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $isSignup) {
                SignupView(isSignup: self.$isSignup)
                }

            .alert(isPresented: $isAlert) {
                    Alert(title: Text("Wrong username or password"), message: Text("Please enter a valid username and password"), dismissButton: .default(Text("cancel"), action: {
                        self.isAlert = false
                    }))
                }

                .navigationBarTitle("Log in",displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

protocol TestView {
    associatedtype T = View
    var myView: T { get set }
}
