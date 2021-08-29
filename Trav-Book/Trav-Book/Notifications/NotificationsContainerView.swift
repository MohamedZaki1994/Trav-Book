//
//  NotificationsContainerView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct NotificationsContainerView: View {
    @State var isDeepLink = true
    @State var deepLinkAtIndex = 0
    @StateObject var viewModel = NotificationsContainerViewModel()
    @State var shouldOpenNotification = false
    @State var selectedPostId = ""

    var body: some View {
        NavigationView {
            List {
                switch viewModel.status {
                case .finished:
                    if let notifications = viewModel.notificationModel {
                                ForEach(notifications, id: \.self) { notification in
                                    ZStack() {

                                        NotificationView(isComingFromDeepLink: notification.id == notifications[deepLinkAtIndex].id ? isDeepLink : false, notification: notification, userId: notification.notificationOwnerId)
                                        .listRowBackground(Color.red)
                                        .onTapGesture {
                                            shouldOpenNotification = true
                                            let index = notifications.firstIndex { notif in
                                                notif.id == notification.id
                                            }
                                            viewModel.readNotification(index: index ?? 0)
                                            selectedPostId = notification.postId
                                            viewModel.status = .initial
                                        }
                                        NavigationLink(destination: NotificationPostView(selectedPostId: $selectedPostId), isActive: self.$shouldOpenNotification) {
                                            EmptyView()
                                        }
                                        .frame(width: 0, height: 0)
                                        .hidden()
                                            }
                                }

                    } else {
                        Text("your notifications are empty")
                    }
                case .initial:
                    Text("").onAppear() {
                        viewModel.loadNotifications()
                    }
                case .loading:
                    Text("loading")
                case .failure(error: let error):
                    Text(error.debugDescription)
                }
            }
            .navigationBarTitle("Notifications")
        }

//        .onAppear() {
//            viewModel.loadNotifications()
//        }

    }

//    func makeNotificationPostView() -> some View {
//        let viewModel = NotificationPostViewModel()
//        viewModel.postID = selectedPostId
//       return NotificationPostView(viewModel: viewModel)
//    }
}



struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
