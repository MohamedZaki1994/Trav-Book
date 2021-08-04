//
//  StarsView.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 04/08/2021.
//  Copyright © 2021 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct StarsView: View {

    @State var isEditable = false
    var stars = ["star.fill"]
    @State var lastFullStar = 2
    var body: some View {
        HStack {
            ForEach (0 ..< 5) { tag in
                Group {
                    if tag <= lastFullStar {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }.onTapGesture {
                    if isEditable {
                        lastFullStar = tag
                    }
                }
//                Image(systemName: "star.fill")
//                Image(systemName: "star.fill")
//                Image(systemName: "star")
//                Image(systemName: "star")
            }
        }
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
