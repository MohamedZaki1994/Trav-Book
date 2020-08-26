//
//  DashboardView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/22/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    @Binding var isNavigation: Bool
    var body: some View {
        VStack {
            Button(action: {
                self.isNavigation = false
            } ){
                Text("Logout")
            }
            Text("hello world")
        }
        .navigationBarBackButtonHidden(true)

    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(isNavigation: .constant(true))
    }
}
