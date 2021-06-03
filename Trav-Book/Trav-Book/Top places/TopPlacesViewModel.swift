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

    let request = RequestHandler()
    func getData() {
        request.getData(path: "topPlaces", modelType: [TopPlacesModel].self) { (model, error) in
            self.dataModel = model
        }
    }
}

enum Rating {
    case excellent
    case good
    case bad
}
