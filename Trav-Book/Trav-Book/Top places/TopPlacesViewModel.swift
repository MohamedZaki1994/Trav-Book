//
//  TopPlacesViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 27/05/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class TopPlacesViewModel: ObservableObject {

    @Published var dataModel: [TopPlacesModel]? {
        didSet {
            filteredDataModel = dataModel
        }
    }
    @Published var filteredDataModel: [TopPlacesModel]?
    @Published var status: Status = .initial
    let request = RequestHandler()
    func getData() {
        status = .loading
        request.load(path: "topPlaces", modelType: TopPlacesModel.self, limit: 5) { [weak self] (model, error) in
            self?.dataModel = model
            self?.dataModel?.sort(by: {
                $0.rating ?? 0 > $1.rating ?? 0
            })
            self?.status = .finished
        }
    }
}

enum Rating {
    case excellent
    case good
    case bad
}
