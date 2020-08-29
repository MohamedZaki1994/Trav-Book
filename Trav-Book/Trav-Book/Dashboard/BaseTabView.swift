//
//  DashboardView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/22/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct BaseTabView: View {
    @Binding var isNavigation: Bool
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Dashboard")
                    }
            }

            VStack {
                Button(action: {
                    self.isNavigation = false
                } ){
                    Text("Logout")
                }
                Text("Profile")
            }.tabItem {
                VStack {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }

        }.navigationBarBackButtonHidden(true)

    }
}

struct BaseTabView_Previews: PreviewProvider {
    static var previews: some View {
        BaseTabView(isNavigation: .constant(true))
    }
}
