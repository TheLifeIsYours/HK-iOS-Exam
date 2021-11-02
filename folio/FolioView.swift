//
//  FolioView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI

struct FolioView: View {
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
                        Spacer()
                    }
                }
                .navigationBarHidden(true)
                .padding(.top, 0.1)
            }
        }.navigationBarHidden(true)
            .navigationTitle("")
            .navigationBarColor(backgroundColor: .systemPurple, tintColor: .white)
    }
}
