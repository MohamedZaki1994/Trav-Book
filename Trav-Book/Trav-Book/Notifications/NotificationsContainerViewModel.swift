//
//  NotificationsContainerViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 23/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase

class NotificationsContainerViewModel: ObservableObject {
    @Published var status: Status = .initial
    @Published var notificationModel: [NotificationModel]?
    let request = RequestHandler()

    func loadNotifications() {
        status = .loading
        request.getData(path: "Notifications/\(CurrentUser.shared.id)", modelType: [NotificationModel].self) { [weak self] (model, error) in
            self?.notificationModel = model
            self?.status = .finished
        }
    }

    func readNotification(index: Int) {
        FirebaseManager.shared.readNotification(notificationIndex: index)
    }
}
