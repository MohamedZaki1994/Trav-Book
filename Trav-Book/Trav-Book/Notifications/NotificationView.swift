//
//  NotificationView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        HStack {
            Image("im")
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Text("Someone has posted a comment")
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
