//
//  ContentView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/21/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isNavigate = false
    
    var body: some View {
        NavigationView {
            VStack {
                LoginView()
                    .padding(.leading,10)
                    .padding(.top,10)
                NavigationLink(destination: BaseTabView(isNavigation: $isNavigate),isActive: $isNavigate) {
                    Text("Log in")
                }
            }.navigationBarTitle("Log in",displayMode: .inline)
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
