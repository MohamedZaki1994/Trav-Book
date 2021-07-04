//
//  TopPlacesViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 27/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class TopPlacesViewModel: ObservableObject {

    @Published var dataModel: [TopPlacesModel]?
    @Published var status: Status = .initial
    let request = RequestHandler()
    func getData() {
        status = .loading
        request.getData(path: "topPlaces", modelType: [TopPlacesModel].self) {[weak self] (model, error) in
            self?.status = .finished
            self?.dataModel = model
        }
    }
}

enum Rating {
    case excellent
    case good
    case bad
}
