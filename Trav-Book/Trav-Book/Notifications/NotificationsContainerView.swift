//
//  NotificationsContainerView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct NotificationsContainerView: View {
    @State var isDeepLink = true
    @State var deepLinkAtIndex = 6
    var body: some View {
        NavigationView {
            List {
                ForEach(1...10, id: \.self) {
                    NotificationView(index: $0,isComingFromDeepLink: deepLinkAtIndex == $0 ? isDeepLink : false, deepLinkAtIndex: deepLinkAtIndex)
                }
            }.navigationBarTitle("Notifications")
        }
    }
}
