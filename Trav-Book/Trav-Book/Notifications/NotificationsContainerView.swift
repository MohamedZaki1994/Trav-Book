//
//  NotificationsContainerView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct NotificationsContainerView: View {
    var body: some View {
        NavigationView {
            List {
                VStack {
                    ForEach(1...10, id: \.self) {
                        Text("\($0).")
                        NotificationView()
                    }
                }
            }.navigationBarTitle("Notifications")
        }
    }
}

struct NotificationsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsContainerView()
    }
}
