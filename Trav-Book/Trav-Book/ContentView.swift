//
//  ContentView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/21/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Firebase
import CoreData

struct ContentView: View {
    @State private var isNavigate = false
    @State var isAlert = false
    @State var username = ""
    @State var password = ""
    @State var isSignup = false
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
                            AuthProvider.shared.signIn(username: self.username, password: self.password) { (success) in
                                if success {
                                    self.isNavigate = true
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
            .onAppear(){
                print("Done")
            }
        }
    }
    func fetchData() -> Result<String,myError> {
        return .failure(myError.badURL)
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

enum myError: Error {
    case badURL, requestFailed
}
