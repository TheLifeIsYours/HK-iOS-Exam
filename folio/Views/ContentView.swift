//
//  ContentView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 29/10/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        TabView {
            FolioView()
                .tabItem {
                    Label("Folios", systemImage: "person.2.circle")
                }
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .font(.custom("Lato-Light", size: 18))
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
