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
    @State var notification: NotificationModel
    @ObservedObject var viewModel = NotificationViewModel()
    @State var userId = ""
    @State var image: Image?
    var body: some View {
        HStack {
            image?
                .imageIconModifier(width: 80, height: 80)
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
            viewModel.loadImage(userId: userId) { (data) in
                if let uiImage = UIImage(data: data) {
                    image = Image(uiImage: uiImage)
                }
            }
        }
    }
}
