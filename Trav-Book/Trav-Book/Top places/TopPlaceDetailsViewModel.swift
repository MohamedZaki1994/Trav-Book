//
//  TopPlaceDetailsViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 05/07/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import UIKit

class TopPlaceDetailsViewModel: ObservableObject {
    var image: UIImage?
    var name: String?
    @Published var model: HotelModel?
    let request = RequestHandler()
    var status: Status = .initial


    func getData() {
        status = .loading
        request.getData(path: "Hotels/\(name!)", modelType: HotelModel.self) {[weak self] (model, error) in
            self?.model = model
            self?.status = .finished
        }
    }
}
