//
//  FactoryManager.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 01/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import SwiftUI

protocol FactoryManagerProtocol {
    associatedtype T: View
    func create(with name: String) -> T
}

@available(iOS 14.0, *)
class FactoryManager: FactoryManagerProtocol {
    func create(with name: String) -> some View {
        NotificationView()
    }

    func makePlaceCardView(model: TopPlacesModel) -> some View {
        let viewModel = PlaceCardViewModel()
        viewModel.dataModel = model
        return PlaceCardView(viewModel: viewModel, factory: self)
    }

    func makeTopPlaceDetailsView(name: String, image: UIImage?, rate: Double?) -> some View {
        let topPlaceDetailsViewModel = TopPlaceDetailsViewModel()
        topPlaceDetailsViewModel.image = image
        topPlaceDetailsViewModel.name = name
        return TopPlaceDetailsView(viewModel: topPlaceDetailsViewModel, rate: rate)
    }

    func makeCommentView(postId: String, userId: String) -> some View {
        CommentView(postId: postId, userId: userId)
    }
}
