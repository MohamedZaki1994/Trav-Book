//
//  UploadPost.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 10/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct UploadPost: View {
    @State var postText: String = ""
    @State var isPresented = false
    @EnvironmentObject var model: DashboardViewModel

    var body: some View {
        VStack {
            Text("write a text").foregroundColor(Color.gray).onTapGesture {
                self.isPresented = true
            }.sheet(isPresented: $isPresented, onDismiss: nil, content: {
                TextField("What's on your mind", text: self.$postText).padding(.top, 30).padding(.leading, 30)
                Button("Post") {
                    let name = CurrentUser.shared.name
                    self.model.postDummy(name: name ?? "", text: self.postText)
                    self.isPresented = false
                    self.postText = ""
                }
                Spacer()
            })
        }
    }
}

struct UploadPost_Previews: PreviewProvider {
    static var previews: some View {
        UploadPost()
    }
}
