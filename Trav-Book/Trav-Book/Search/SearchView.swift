//
//  SearchView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 03/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var searchingText = ""
    @State var searchingCountry = ""
    @State var isAdvanced = false
    var body: some View {
        VStack {
        TextField("Search for a hotel", text: $searchingText).padding()
            Button("Advancded") {
                isAdvanced.toggle()
            }
            if isAdvanced {
                Text("advanced search")
                TextField("type the country", text: $searchingCountry).padding()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
