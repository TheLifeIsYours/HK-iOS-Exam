//
//  FolioDetailsView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI
import CachedAsyncImage

struct FolioDetailsView: View {
    @Environment(\.managedObjectContext) var moc
    var folioRequest: FetchRequest<Folio>   
    
    @State var playState = false
    @State var counter = 0
    
    init(folio: Folio) {
        folioRequest = FetchRequest<Folio>(entity: Folio.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id == %@", folio.id))
    }
    
    var body: some View {
        ZStack {
            PurpleGradient
            
            if let folio = folioRequest.wrappedValue.first {
                VStack{
                    ZStack(alignment: .bottomTrailing){
                        CachedAsyncImage(url: URL(string: folio.pictureLarge)) {image in
                            image
                                .resizable()
                                .frame(maxWidth: 200, maxHeight: 200)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                                )
                        } placeholder: {
                            ProgressView()
                        }
                        
                        if(folio.date.get(.weekOfMonth) == Date.now.get(.weekOfMonth)) {
                            Button(action: {
                                playState.toggle()
                                counter += 1
                            }, label: {
                                Text("🎉")
                                    .padding()
                                    .background(Blur(style: .systemUltraThinMaterial))
                                    .cornerRadius(10)
                            }).onAppear {
                                counter += 1
                            }
                        }
                    }
                    
                    HStack {
                        Image(systemName: "person").scaleEffect(1.25)
                        Text(folio.firstName)
                        Text(folio.lastName)
                        Spacer()
                    }.padding(.top)
                    
                    HStack {
                        Image(systemName: "phone").scaleEffect(1.25)
                        Text(folio.phone)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding(.top)
                    
                    HStack {
                        Image(systemName: "envelope").scaleEffect(1.25)
                        Text(folio.email)
                        Spacer()
                    }.padding(.top)
                    
                    HStack {
                        Image(systemName: "map").scaleEffect(1.25)
                        Text("\(folio.city), \(folio.state)")
                        Spacer()
                        
                        NavigationLink(destination: MapView(focus: folio)) {
                            Image(systemName: "location.magnifyingglass")
                        }
                    }.padding(.top)
                    
                    HStack {
                        Image(systemName: "calendar").scaleEffect(1.25)
                            Text(folio.date, style: .date)
                        Spacer()
                        
                        HStack {
                            Text("🎂").scaleEffect(1.25)
                            Text("Age \(folio.age)")
                        }
                        Spacer()
                    }.padding(.top)
                    
                    Spacer()
                    
                    NavigationButton(
                        action: {},
                        destination: {
                            FolioEditView(folio: folio)
                            .environment(\.managedObjectContext, self.moc)
                        },
                        label: {
                            HStack {
                                Text("Edit")
                                Image(systemName: "pencil")
                                    .font(Font.title.weight(.light))
                                    .opacity(0.6)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Blur(style: .systemUltraThinMaterial))
                            .cornerRadius(10)
                    })
                }
                .padding()
                .background(Blur(style: .systemUltraThinMaterial))
                .cornerRadius(10)
                .padding()
                .foregroundColor(.white)
                .navigationTitle(folio.firstName)
            }
            
            Confetti(particles: 30, duration: 5, count: $counter)
        }
    }
}

struct Confetti: View {
    @State var offset: CGFloat = 0
    
    @State var particles: Int
    @State var duration: Double
    
    @Binding var animationCount: Int
    @State var doneAnimationCount = 0
    
    init(particles: Int, duration: Double, count: Binding<Int>) {
        _animationCount = count
        _particles = State(wrappedValue: particles)
        _duration = State(wrappedValue: duration)
    }
    
    var body: some View {
        ZStack {
            ForEach(doneAnimationCount..<animationCount, id: \.self) { i in
                ZStack {
                    ForEach(1..<particles) { j in
                        let randomX = CGFloat.random(in: CGFloat(0)...CGFloat(UIScreen.width))
                        let randomY = CGFloat.random(in: CGFloat(-UIScreen.height / 2)...CGFloat(0))
                        
                        Particle(position: CGPoint(x: randomX, y: randomY), duration: duration)
                    }
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        if(doneAnimationCount < animationCount ) {
                            doneAnimationCount += 1
                        }
                    }
                }
            }
        }
    }
}

struct Particle: View {
    @State var position:CGPoint = CGPoint(x: 100, y: 300)
    @State var offset:CGPoint = CGPoint(x: 0, y: UIScreen.height * 2)
    
    var velocity:CGPoint = CGPoint(
        x: CGFloat.random(in: CGFloat(-UIScreen.width/2)...CGFloat(UIScreen.width/2)),
        y: CGFloat.random(in: CGFloat(0)...CGFloat(UIScreen.height))
    )
    
    @State var duration: Double
    @State var playState = false
    
    init(position: CGPoint, duration: Double) {
        _position = State(wrappedValue: position)
        _duration = State(wrappedValue: duration)
    }
    
    var body: some View {
        Text(["🎂", "❤️", "🎉", "🎊", "🎁"][Int.random(in: 0...4)])
            .scaleEffect(playState ? -2 : 2)
            .ignoresSafeArea()
            .position(
                x: playState ? position.x + offset.x + velocity.x : position.x,
                y: playState ? position.y + offset.y + velocity.y : position.y
            )
            .animation(.easeIn(duration: duration), value: playState)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    playState = true
                }
            }
    }
}
