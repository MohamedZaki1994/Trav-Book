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
    var body: some View {
        GeometryReader { geo in
            VStack {
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
                            //                            .alignmentGuide(.midAccountAndName) { (d) -> CGFloat in
                            //                                DispatchQueue.main.async {
                            //                                    self.height = d.height
                            //                                }
                            //                                return d[VerticalAlignment.center]
                            //                            }
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
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    self.isAlert = true
                                }
                            }

                        } else {
                            self.isAlert = true
                        }
                        //                        let fetch = LoggedUser.fetchRequest() as NSFetchRequest<LoggedUser>
                        //                        let predicate = NSPredicate(format: "name = %@", "zaki")
                        ////                        fetch.predicate = predicate
                        //                        let sorter = NSSortDescriptor(key: "age", ascending: true)
                        //                        let sorter1 = NSSortDescriptor(key: "name", ascending: false)
                        //                        fetch.sortDescriptors = [sorter, sorter1]
                        //                   let user = try! self.context.fetch(fetch) as? [LoggedUser]
                        //                        print("")
                    }
                    Button("sign up") {
                        self.isSignup = true
                        //                        let user = LoggedUser(context: self.context)
                        //                        user.name = "Ali"
                        //                        user.age = 33
                        //                        user.postss = ["1","2","3"]
                        //                        let favorite = Favorite(context: self.context)
                        //                        favorite.numberOfLike = 5
                        //                        favorite.numberOfDislike = 2
                        //                        user.addToFavorite(favorite)
                        //                        try! self.context.save()
                    }
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
