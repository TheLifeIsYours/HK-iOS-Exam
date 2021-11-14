//
//  FolioListCard.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI
import CachedAsyncImage

struct FolioListCard: View {
    @Environment(\.managedObjectContext) var moc
    var folioRequest: FetchRequest<Folio>
    
    init(folio: Folio) {
        folioRequest = FetchRequest<Folio>(entity: Folio.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id == %@", folio.id))
    }
    
    var body: some View {
        Spacer()
        HStack {
            if let folio = folioRequest.wrappedValue.first {
                CachedAsyncImage(url: URL(string: folio.pictureMedium)) { image in
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
                        Text(folio.firstName)
                        Text(folio.lastName)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "phone")
                        Text(folio.phone)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                }
                
                NavigationButton(
                    action: {
                    },
                    destination: {
                        FolioDetailsView(folio: folio)
                            .environment(\.managedObjectContext, self.moc)
                            .onDisappear() {
                                
                            }
                    },
                    label: {
                        Image(systemName: "chevron.right")
                            .scaleEffect(1.5)
                            .font(Font.title.weight(.light))
                            .opacity(0.6)
                    }
                )
            }
        }
        .padding()
        .background(Blur(style: .systemUltraThinMaterial))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
