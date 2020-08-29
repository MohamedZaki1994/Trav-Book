//
//  PostView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/27/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct PostView: View {
    @State var postText: String = ""
    @State var profileImageString: String = ""
    @State var profileName: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                Text(profileName)
            }
            Text(postText)
                .background(Color.gray)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
