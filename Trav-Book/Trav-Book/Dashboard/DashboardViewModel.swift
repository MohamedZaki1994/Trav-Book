//
//  DashboardViewModel.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var isLoading = false

    @Published var posts = [PostModel]()
        {
        didSet {
            print("Fired")
            isLoading = false
        }
    }

    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {

            let post1 = PostModel( name: "Zaki", imageName: "nothing", postText: "This is the best App")
            let post2 = PostModel(name: "Onikage", imageName: nil, postText: "Agree")
            let post3 = PostModel(name: "Omar", imageName: nil, postText: "Jehad")
            self.posts = [post1,post2,post3]
        }
    }
}


struct PostModel: Identifiable {

    var id = UUID()
    var name: String?
    var imageName: String?
    var postText: String?
}
