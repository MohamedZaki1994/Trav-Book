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
    var action: ((Int) -> Void)?
    var body: some View {
        HStack {
            ForEach (1 ... 5, id: \.self) { tag in
                Group {
                    if tag <= lastFullStar {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }.onTapGesture {
                    if isEditable {
                        lastFullStar = tag
                        action?(lastFullStar)
                    }
                }
            }
        }
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
