//
//  folioApp.swift
//  folio
//
//  Created by Mats Daniel Larsen on 29/10/2021.
//

import SwiftUI

@main
struct folioApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, PersistenceProvider.default.context)
        }
    }
}
