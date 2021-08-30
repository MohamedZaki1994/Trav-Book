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
    @StateObject var viewModel = BaseTabViewModel()
    @EnvironmentObject var baseTabViewModel: BaseTabViewModel
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
                    Text("Notifications\(viewModel.count == 0 ? "" : "\(viewModel.count)")")
                }.tag(2)

            ProfileView(profileViewModel: ProfileViewModel(), viewModel: dashboardViewModel)
                .tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
            }.tag(3)
        }
        .onChange(of: selectedTab, perform: { value in
            if selectedTab == 2 {
                viewModel.count = 0
            }
        })
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
            viewModel.loadNotifications()
        }
    }
}

class BaseTabViewModel: ObservableObject {
    @Published var status: Status = .initial
    let request = RequestHandler()
    @Published var count = 0

    func loadNotifications() {
        status = .loading
        request.getData(path: "Notifications/\(CurrentUser.shared.id)", modelType: [NotificationModel].self) { [weak self] (model, error) in
            model?.forEach({
                if !$0.isRead {
                    self?.count += 1
                }
            })
            self?.status = .finished
        }
    }

}
