//
//  NotificationViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 29/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import Firebase

class NotificationViewModel: ObservableObject {
    @Published var image: Data?

    func loadImage(userId: String, completion: ((Data) -> Void)?) {
        FirebaseManager.shared.loadImage(userId: userId, completion: completion)
    }
}
