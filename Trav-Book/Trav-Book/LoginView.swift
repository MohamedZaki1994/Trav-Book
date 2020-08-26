//
//  LoginView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/21/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isAlert = false
    @State private var height: CGFloat = 0
    
    var body: some View {
        HStack(alignment:.midAccountAndName){
            //
            Spacer()
            VStack(alignment: .leading,spacing: 22){
                Text("Username")
                    .padding(.bottom,1)
                    .textStyle()

                Text("Pasword")
//                    .padding(.)
                    .textStyle()
                    .alignmentGuide(.midAccountAndName) { (d) -> CGFloat in
                        return d[VerticalAlignment.center]
                }

                Spacer()
            }
            .animation(.default)

            //
            VStack(spacing: 20.0){


                TextField("Enter your Username", text: self.$username)
                TextField("Enter your Password", text: self.$password)
                    .alignmentGuide(.midAccountAndName) { (d) -> CGFloat in
                        DispatchQueue.main.async {
                            self.height = d.height
                        }
                        return d[VerticalAlignment.center]
                }


                Spacer()
            }

        }.navigationBarTitle("Login",displayMode: .inline)

            .alert(isPresented: $isAlert, content: {
                Alert(title: Text("Title"), message: Text("mesg"), primaryButton: .default(Text("Sure?"), action: {
                    print("said sure")
                }), secondaryButton: .cancel())
            })

    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 6s"))
        }
    }
}

extension HorizontalAlignment {
    enum TextAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let horizontalAlignment = HorizontalAlignment(TextAlignment.self)
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct WidthPreferenceKey: PreferenceKey {
    
    static var defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
    
}

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(Color.green)
            .font(.system(size: 16, weight: .bold, design: .default))
        
    }
}

extension View {
    func textStyle() -> some View {
        self.modifier(TextStyle())
    }
}
