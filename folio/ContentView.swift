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
            HomeView()
                .tabItem {
                    Label("Browse", systemImage: "list.dash")
                }
            
            Text("Folios")
                .tabItem {
                    Label("Folios", systemImage: "person.crop.circle")
                }
        
            Text("Home")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct HomeView: View {
    @ObservedObject var api = PeopleAPI()
    
    var body: some View {
        NavigationView {
            ZStack {
                PurpleGradient
                
                ScrollView {
                    if let people = api.data?.results {
                        ForEach(people, id: \.id!.value!) { person in
                            FolioListCard(person: person)
                        }
                    }
                }.edgesIgnoringSafeArea(.top)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct FolioListCard: View {
    var person: Person!
    
    var body: some View {
        Spacer()
        HStack {
            AsyncImage(url: URL(string: person.picture!.medium!)) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(5)
            } placeholder: {
                ProgressView()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Image(systemName: "person")
                    Text(person.name!.first!)
                    Text(person.name!.last!)
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "phone")
                    Text(person.phone!)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
            }
            
            NavigationLink(destination: FolioPersonView(person: person)) {
                ImageButtonRight()
            }
        }
        .padding()
        .background(Blur(style: .systemUltraThinMaterial))
        .cornerRadius(10)
        .foregroundColor(.white)
        .padding([.leading, .trailing])
    }
}

struct FolioPersonView: View {
    var person: Person!
    
    var body: some View {
        ZStack {
            PurpleGradient
                
            VStack{
                AsyncImage(url: URL(string: person.picture!.large!)) {image in
                    image
                        .resizable()
                        .frame(maxWidth: 200, maxHeight: 200)
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                        )
                } placeholder: {
                    ProgressView()
                }
                
                HStack {
                    Image(systemName: "person").scaleEffect(1.25)
                    Text(person.name!.first!)
                    Text(person.name!.last!)
                    Spacer()
                }.padding(.top)
                
                HStack {
                    Image(systemName: "phone").scaleEffect(1.25)
                    Text(person.phone!)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.padding(.top)
                
                HStack {
                    Image(systemName: "mail").scaleEffect(1.25)
                    Text(person.email!)
                    Spacer()
                }.padding(.top)
                
                HStack {
                    Image(systemName: "map").scaleEffect(1.25)
                    Text("\(person.location!.city!), \(person.location!.state!)")
                    Spacer()
                }.padding(.top)
                
                HStack {
                    Image(systemName: "calendar").scaleEffect(1.25)
                    Text(person.dateOfBirth!.date!, style: .date)
                    Spacer()
                    
                    HStack {
                        Text("🎂").scaleEffect(1.25)
                        Text("Age \(person.dateOfBirth!.age!)")
                    }
                    Spacer()
                }.padding(.top)
                
                Spacer()
            }
            .padding()
            .background(Blur(style: .systemUltraThinMaterial))
            .cornerRadius(10)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 20))
        }
    }
}

struct ImageButtonRight: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .scaleEffect(1.5)
            .font(Font.title.weight(.light))
            .opacity(0.6)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

private var PurpleGradient: some View {
    LinearGradient(gradient: Gradient(colors: [.purple, .indigo]), startPoint: .bottomLeading, endPoint: .top)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
