//
//  DetailedPersonMarker.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI
import CachedAsyncImage

struct DetailedPersonMarker: View {
    var marker: PersonLocation
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: marker.person.pictureLarge)){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            
            VStack {
                HStack {
                    Image(systemName: "map").scaleEffect(1.25)
                    Text("\(marker.person.city), \(marker.person.state)")
                    Spacer()
                }.padding([.top])
                
                HStack {
                    Image(systemName: "person").scaleEffect(1.25)
                    Text(marker.person.firstName)
                    Text(marker.person.lastName)
                    Spacer()
                }.padding([.top])
                
                HStack {
                    Image(systemName: "phone").scaleEffect(1.25)
                    Text(marker.person.phone)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.padding([.top, .bottom])
            }
            .fixedSize()
        }
        .font(.system(size: 10))
        .foregroundColor(.accentColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
        )
        .background(Blur(style: .systemUltraThinMaterial))
        .cornerRadius(10)
        .padding()
    }
}
