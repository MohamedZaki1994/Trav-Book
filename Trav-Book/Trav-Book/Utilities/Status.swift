//
//  Status.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 04/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

enum Status {
    case initial
    case loading
    case finished
    case failure(error: Error?)
}
