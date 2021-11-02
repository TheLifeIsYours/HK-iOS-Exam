//
//  ContentView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 29/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FolioView()
                .tabItem {
                    Label("Folios", systemImage: "person.2.circle")
                }
            
            Text("Folio Map View")
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        
            Text("Home")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

//struct ImageButtonRight: View {
//    var body: some View {
//        Image(systemName: "chevron.right")
//            .scaleEffect(1.5)
//            .font(Font.title.weight(.light))
//            .opacity(0.6)
//    }
//}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

var PurpleGradient: some View {
    LinearGradient(gradient: Gradient(colors: [.purple, .indigo]), startPoint: .bottomLeading, endPoint: .top)
}

/*
     Custom NavigationView Bar in SwiftUI
     Using custom colors in the navigation bar
     https://medium.com/swlh/custom-navigationview-bar-in-swiftui-4b782eb68e94
     https://gist.github.com/apatronl/29b6c82085afd1c6177715d88411aaf4
 */
extension View {
  func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View {
    self.modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
  }
}

struct NavigationBarColor: ViewModifier {

  init(backgroundColor: UIColor, tintColor: UIColor) {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = backgroundColor
    coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
                   
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = tintColor
  }

  func body(content: Content) -> some View {
    content
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
