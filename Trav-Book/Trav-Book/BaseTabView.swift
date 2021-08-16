//
//  DashboardView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/22/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct BaseTabView: View {
    @State var isRefresh = true
    @State var refreshing = false
    @State var selectedTab = 2
    @State var isDeepLink = false
    @State var deepLinkAtIndex = 0
    let dashboardViewModel = DashboardViewModel()
    let topPlaceViewModel = TopPlacesViewModel()
    var factory: FactoryManager?
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(viewModel: dashboardViewModel, factory: factory)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Dashboard")
                    }
                }.tag(0)

            TopPlacesView(viewModel: topPlaceViewModel, factory: factory!)
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Top places")
                }.tag(1)
            NotificationsContainerView(isDeepLink: isDeepLink, deepLinkAtIndex: deepLinkAtIndex)
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notifications")
                }.tag(2)
            ProfileView(profileViewModel: ProfileViewModel(), viewModel: dashboardViewModel)
                .tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
            }.tag(3)
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
