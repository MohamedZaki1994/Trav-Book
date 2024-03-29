//
//  LoginView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/21/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State private var isAlert = false
    @State private var height: CGFloat = 0
    @State var isSecure = true
    @State var isSignup = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var session: AuthProvider

    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Welcome to trav book").font(.system(size: 20, weight: .bold)).padding(.top, 50)
                VStack(spacing: 10.0){
                    TextField("Enter your Username", text: self.$username)
                        .padding()
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                        .cornerRadius(10)
                        .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    HStack {
                        if isSecure {
                            SecureField("Enter your Password", text: self.$password)
                        } else {
                            TextField("Enter your Password", text: self.$password)
                        }
                        Button {
                            isSecure.toggle()
                        } label: {
                            Image(systemName: "eye")
                        }
                    }
                    .padding()
                    .background(Color(red: 211/255, green: 211/255, blue: 211/255))
                    .cornerRadius(10)
                    .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }.padding(.top, (geo.size.height / 5))
                //            }
                HStack(spacing: 50) {
                    Button("Login") {
                        if !self.username.isEmpty, !self.password.isEmpty {
                            AuthProvider.shared.signIn(username: self.username, password: self.password) { (success) in
                                if success {
                                    self.session.user = CurrentUser.shared

                                } else {
                                    self.isAlert = true
                                }
                            }

                        } else {
                            self.isAlert = true
                        }
                    }
                    .frame(width: 150, height: 50)
                    .background(Color.black)
                    .foregroundColor(.red)
                    .cornerRadius(5)

                    Button("sign up") {
                        self.isSignup = true
                    }
                    .frame(width: 150, height: 50)
                    .background(Color.black)
                    .foregroundColor(.red)
                    .cornerRadius(5)

                }

            }
        }
        .sheet(isPresented: $isSignup) {
            SignupView(isSignup: self.$isSignup)
        }

        .alert(isPresented: $isAlert, content: {
            Alert(title: Text("Title"), message: Text("mesg"), primaryButton: .default(Text("Sure?"), action: {
                print("said sure")
            }), secondaryButton: .cancel())
        })
    }
    
    //    struct LoginView_Previews: PreviewProvider {
    //        static var previews: some View {
    //            LoginView()
    ////                .previewDevice(PreviewDevice(rawValue: "iPhone 6s"))
    //        }
    //    }
}

extension HorizontalAlignment {
    enum TextAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let horizontalAlignment = HorizontalAlignment(TextAlignment.self)
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct WidthPreferenceKey: PreferenceKey {
    
    static var defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
    
}

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(Color.green)
            .font(.system(size: 16, weight: .bold, design: .default))
        
    }
}

extension View {
    func textStyle() -> some View {
        self.modifier(TextStyle())
    }
}
