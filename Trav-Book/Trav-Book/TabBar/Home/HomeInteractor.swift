//
//  HomeInteractor.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/27/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class HomeInteractor {
    let viewModel = HomeViewModel()
    func fetchData(completion: (HomeViewModel?) -> Void) {
        Repository.getData(fileName: "OfflineData") { (model, error) in
            if error != nil {
                return
            }
            viewModel.section = model?.section
            completion(viewModel)
        }
    }
}

class HomeViewModel {
    var section: [Section]?
}
