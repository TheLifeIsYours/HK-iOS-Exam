//
//  FolioView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI
import Foundation
import CoreData

struct FolioView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Folio.entity(), sortDescriptors: [], predicate: NSPredicate(format: "edited == true and removed == false")) var storedFolios: FetchedResults<Folio>
    @FetchRequest(entity: Folio.entity(), sortDescriptors: [], predicate: NSPredicate(format: "edited == false and removed == false")) var folios: FetchedResults<Folio>
    
    @FetchRequest(entity: AppStorage.entity(), sortDescriptors: []) var appStorages: FetchedResults<AppStorage>

    @ObservedObject var api = PeopleAPI()
    
    var body: some View {
        NavigationView {
            ZStack {
                PurpleGradient
                
                VStack {
                    ScrollView {
                        if !storedFolios.isEmpty {
                            VStack {
                                Text("Saved Folios")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Blur(style: .systemUltraThinMaterial))
                                    .cornerRadius(4)
                                    .padding([.horizontal, .top])
                                
                                ForEach(storedFolios, id: \.self) { folio in
                                    if !folio.removed {
                                        FolioListCard(folio: folio)
                                            .environment(\.managedObjectContext, self.moc)
                                    }
                                }
                            }.padding(.bottom)
                        }
                        
                        VStack {
                            Group {
                                if let _ = api.data?.results {
                                    Text("Online Folios")
                                        .onAppear(perform: loadApiData)
                                } else {
                                    Text("Local Folios")
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Blur(style: .systemUltraThinMaterial))
                            .cornerRadius(4)
                            .padding([.horizontal, .top])
                            
                            ForEach(folios, id: \.self) { folio in
                                if !folio.removed {
                                    FolioListCard(folio: folio)
                                        .environment(\.managedObjectContext, self.moc)
                                }
                            }
                        }.padding(.bottom)
                    }
                    .navigationBarHidden(true)
                    .padding([.top, .bottom], 0.1)
                }
            }.onAppear() {
                if appStorages.isEmpty {
                    let _ = AppStorage(context: moc)
                    try? moc.save()
                }
            }
        }
        .navigationBarColor(backgroundColor: .systemPurple, tintColor: .white)
    }
    
    func loadApiData() {
        print("Loading Foilio Data")
        
        //Save folios in CoreData if api person data is not found
        if let people = api.data?.results {
            for (_, person) in people.enumerated() {
                
                var isStored = false
                 
                for(_, folio) in folios.enumerated() {
                    if(folio.id == person.id?.value) {
                        isStored = true
                    }
                }

                //Store person Folio if not previously stored
                if(isStored == false) {
                    Folio.storeFolio(person: person, seed: appStorages[0].seed, context: moc)
                }
            }
        }
    }
}
