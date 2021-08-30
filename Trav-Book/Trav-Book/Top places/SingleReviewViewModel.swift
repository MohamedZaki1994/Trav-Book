//
//  SingleReviewViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 30/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class SingleReviewViewModel: ObservableObject {

    func loadImage(userId: String, completion: ((Data) -> Void)?) {
        FirebaseManager.shared.loadImage(userId: userId, completion: completion)
    }
}
