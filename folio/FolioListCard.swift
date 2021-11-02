//
//  FolioListCard.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI

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
            
            NavigationLink(destination: FolioDetailsView(person: person)) {
                Image(systemName: "chevron.right")
                    .scaleEffect(1.5)
                    .font(Font.title.weight(.light))
                    .opacity(0.6)
            }
        }
        .padding()
        .background(Blur(style: .systemUltraThinMaterial))
        .cornerRadius(10)
        .foregroundColor(.white)
        .padding([.leading, .trailing])
    }
}
