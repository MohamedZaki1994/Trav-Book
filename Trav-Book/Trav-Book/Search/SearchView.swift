//
//  SearchView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 03/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Combine

@available(iOS 14.0, *)
struct SearchView: View {
    @State var searchingText = ""
    @State var searchingCountry = ""
    @State var isAdvanced = false
    @State var isEditing = false
    @ObservedObject var viewModel: TopPlacesViewModel
    var body: some View {
        VStack {
            HStack {
                TextField("Search for a hotel", text: $searchingText).onChange(of: searchingText) { _ in
                    isEditing = searchingText.isEmpty ? false : true
                    seachBySeparateCharacters()
                }.padding()
                if isEditing {
                    Button("Cancel") {
                        searchingText = ""
                        seachBySeparateCharacters()
                        isEditing = false
                    }.padding()
                }
            }
            Button("Advancded") {
                isAdvanced.toggle()
            }
            if isAdvanced {
                Text("advanced search")
                TextField("type the country", text: $searchingCountry).onChange(of: searchingCountry, perform: { _ in
                    searchByCountry()
                })
                    .padding()
            }
        }
    }

    func seachBySeparateCharacters() {
        if searchingText.isEmpty || searchingCountry.isEmpty{
            viewModel.filteredDataModel = viewModel.dataModel
        }
        if searchingText.isEmpty {
            searchByCountry()
        }
        searchingText.forEach { (character) in
            viewModel.filteredDataModel = viewModel.filteredDataModel?.filter({ model in
                searchingText.isEmpty ? true : (model.name?.lowercased().contains(searchingText.lowercased()) ?? false) || (model.name?.lowercased().contains(character.lowercased()) ?? false)
            })
        }
    }

    func searchByCountry() {
        if searchingText.isEmpty || searchingCountry.isEmpty {
            viewModel.filteredDataModel = viewModel.dataModel
        }
        searchingText.forEach { (character) in
            viewModel.filteredDataModel = viewModel.filteredDataModel?.filter({ model in
                searchingText.isEmpty ? true : (model.name?.lowercased().contains(searchingText.lowercased()) ?? false) || (model.name?.lowercased().contains(character.lowercased()) ?? false)
            })
        }
        searchingCountry.forEach { (text) in
            viewModel.filteredDataModel = viewModel.filteredDataModel?.filter({ (model) -> Bool in
                (model.region?.lowercased().contains(searchingCountry.lowercased()) ?? false)
            })
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
