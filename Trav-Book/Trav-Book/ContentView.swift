//
//  ContentView.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 8/21/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI
import Firebase
import CoreData

@available(iOS 14.0, *)
struct ContentView: View {
    @State private var isNavigate = false
    @State var isAlert = false
    @State var username = ""
    @State var password = ""
    @State var isSignup = false
    @State var showLogin = false
    @State var isLoading = false
    @State var selectedTab = 0
    @State var isDeepLink = false
    @State var deepLinkAtIndex = 0
    @EnvironmentObject var session: AuthProvider
    var factory = FactoryManager()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var body: some View {
        Group {
            if session.user == nil {
                if self.isLoading {
                    LoginView().overlay(ProgressView().progressViewStyle(GaugeProgressStyle())
                                            .frame(width: 100, height: 100)
                    )
                } else {
                    LoginView()
                }
            } else {
                BaseTabView(selectedTab: selectedTab, isDeepLink: isDeepLink, deepLinkAtIndex: deepLinkAtIndex, factory: factory)
            }
        } .onAppear() {
            if let id = Auth.auth().currentUser?.uid {
                isLoading = true
                AuthProvider.shared.getUserData(id) { (flag) in
                    print(flag)
                    self.isLoading = false
                }
            }
        }
    }

    func fetchData() -> Result<String,myError> {
        return .failure(myError.badURL)
    }
}

protocol TestView {
    associatedtype T = View
    var myView: T { get set }
}

enum myError: Error {
    case badURL, requestFailed
}

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.blue
    var strokeWidth = 10.0
    @State var shouldAnimate = false

    func makeBody(configuration: Configuration) -> some View {
        return ZStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.init(degrees: self.shouldAnimate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
        }.onAppear() {
            shouldAnimate = true
        }
    }
}


extension View {
    @ViewBuilder
    func navigate<Value, Destination: View>(
        using binding: Binding<Value?>,
        @ViewBuilder destination: (Value) -> Destination
    ) -> some View {
        background(NavigationLink(binding, destination: destination))
    }
}

extension NavigationLink where Label == EmptyView {
    init?<Value>(
        _ binding: Binding<Value?>,
        @ViewBuilder destination: (Value) -> Destination
    ) {
        guard let value = binding.wrappedValue else {
            return nil
        }

        let isActive = Binding(
            get: { true },
            set: { newValue in if !newValue { binding.wrappedValue = nil } }
        )

        self.init(destination: destination(value), isActive: isActive, label: EmptyView.init)
    }
}
