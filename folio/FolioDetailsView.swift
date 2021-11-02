//
//  FolioDetailsView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI

struct FolioDetailsView: View {
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
