//
//  NotificationView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct NotificationView: View {
    @State var shouldOpenNotification = false
    @State var isComingFromDeepLink = false
    var notification: NotificationModel
    var body: some View {
        HStack {
            Image("im")
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.top)
                .padding(.bottom)
                .padding(.trailing)
            Text("\(notification.notificationOwnerName) has commented on a post")

        }
        .overlay(
            Rectangle()
                .frame(width: UIScreen.main.bounds.width + 80)
                .background(Color.blue)
                .opacity(notification.isRead ? 0 : 0.2)
        )
        .onAppear() {
            if isComingFromDeepLink {
                shouldOpenNotification = true
                isComingFromDeepLink = false
            }
        }
    }
}
