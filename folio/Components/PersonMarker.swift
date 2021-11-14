//
//  PersonMarker.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI
import CachedAsyncImage

struct PersonMarker: View {
    @State var folio: Folio
    var marker: PersonLocation
    
    init(marker: PersonLocation) {
        self.marker = marker
        _folio = State(wrappedValue: marker.person)
    }
    
    var body: some View {
        NavigationButton(
            action: {
            },
            destination: {
                FolioDetailsView(folio: folio)
            },
            label: {
                HStack {
                    CachedAsyncImage(url: URL(string: marker.person.pictureThumbnail)) { image in
                        image
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(marker.person.firstName)
                        .padding(.trailing)
                }
                .fixedSize()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                )
                .background(Blur(style: .systemUltraThinMaterial))
                .cornerRadius(10)
                .padding()
            }
        )
    }
}
