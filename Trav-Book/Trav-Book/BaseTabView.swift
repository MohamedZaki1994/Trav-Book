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
    @State var isRefresh = true
    @State var refreshing = false
    var body: some View {
        TabView {
//            if isRefresh {
                DashboardView(refreshing: $refreshing)
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Dashboard")

                        }
                }
//            }
//            else {
//                Text("refreshing").onAppear() {
//                    self.isRefresh = true
//                }
//            }


            ProfileView(isNavigation: $isNavigation).tabItem {
                VStack {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }


            }
        .navigationBarItems(trailing:
            Button(action: {
                self.isRefresh = false
                self.refreshing = true
            }) {
                Image(systemName:"arrow.counterclockwise.circle.fill").padding()
            }
        .buttonStyle(DefaultButtonStyle()))
        .navigationBarBackButtonHidden(true)

    }

}

struct BaseTabView_Previews: PreviewProvider {
    static var previews: some View {
        BaseTabView(isNavigation: .constant(true))
    }
}
