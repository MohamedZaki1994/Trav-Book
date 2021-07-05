//
//  DashboardView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/22/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct BaseTabView: View {
    @State var isRefresh = true
    @State var refreshing = false
    let dashboardViewModel = DashboardViewModel()
    let topPlaceViewModel = TopPlacesViewModel()
    var body: some View {

        TabView() {
            DashboardView(viewModel: dashboardViewModel, refreshing: $refreshing)
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Dashboard")

                        }
                }

            TopPlacesView(viewModel: topPlaceViewModel)
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Top places")
                }
            NotificationsContainerView()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notifications")
                }
            if #available(iOS 14.0, *) {
                ProfileView(profileViewModel: ProfileViewModel(), viewModel: dashboardViewModel).tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }
            } else {
                // Fallback on earlier versions
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
        .onAppear(){
            print("Appear")
        }

    }

}

//struct BaseTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        BaseTabView(isNavigation: .constant(true))
//    }
//}
