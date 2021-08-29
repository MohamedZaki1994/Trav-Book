//
//  NotificationModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 23/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

struct NotificationModel: Codable, Identifiable, Hashable {
    let id: String
    let notificationOwnerId, notificationOwnerName, notificationOwnerImageName, postId: String
    let isRead: Bool
}
