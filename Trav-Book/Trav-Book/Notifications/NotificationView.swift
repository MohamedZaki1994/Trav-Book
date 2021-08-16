//
//  NotificationView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    @State var shouldOpenNotification = false
    @State var index: Int = 0
    @State var isComingFromDeepLink = false
    var body: some View {
        HStack {
            Image("im")
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Text("Someone has posted a comment")
            NavigationLink(destination: NotificationPostView(index: index), isActive: self.$shouldOpenNotification) {
                EmptyView()
            }
        }.onTapGesture {
            shouldOpenNotification = true
        }
        .onAppear() {
            if isComingFromDeepLink {
                shouldOpenNotification = true
                isComingFromDeepLink = false
            }
        }
    }
}
