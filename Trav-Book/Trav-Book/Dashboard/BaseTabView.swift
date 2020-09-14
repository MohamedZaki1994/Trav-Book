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
    var body: some View {
        TabView {

            if isRefresh {
                DashboardView()
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Dashboard")

                        }
                }
            }
            else {
                Text("refreshing").onAppear() {
                    self.isRefresh = true
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

        }
        .navigationBarItems(trailing:
            Button(action: {
                self.isRefresh = false
            }) {
                Image(systemName:"arrow.counterclockwise.circle.fill")
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
