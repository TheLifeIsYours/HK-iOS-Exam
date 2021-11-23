//
//  folioApp.swift
//  folio
//
//  Created by Mats Daniel Larsen on 29/10/2021.
//

import SwiftUI

@main
struct folioApp: App {
    @State var viewSplash: Bool = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if viewSplash {
                    SplashView()
                } else {
                    ContentView().environment(\.managedObjectContext, PersistenceProvider.default.context)
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    viewSplash = false
                }
            }
        }
    }
}
