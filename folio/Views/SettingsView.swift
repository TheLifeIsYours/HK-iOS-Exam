//
//  SettingsView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 12/11/2021.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Folio.entity(), sortDescriptors: []) var folios: FetchedResults<Folio>
    @FetchRequest(entity: AppStorage.entity(), sortDescriptors: []) var appStorages: FetchedResults<AppStorage>
    
    @State var seed = "ios"
    
    var body: some View {
        ZStack {
            PurpleGradient
            
            VStack {
                Text("Folio Settings")
                    .padding(.top)
                
                ScrollView {
                    TextInputCard(label: "API Seed: ", placeholder: "seed", text: $seed)
                    ButtonAlertAction(
                        label: "Clear Storage",
                        icon: "externaldrive.badge.xmark",
                        alertTitle: "Clear Storage",
                        alertMessage: "Are you sure you want to clear your storage?",
                        alertPrimaryButton: "Clear",
                        action: {
                            self.seed = "ios"
                            appStorages[0].seed = self.seed
                            
                            for folio in folios {
                                print("Deleting folio: \(folio.firstName)")
                                moc.delete(folio)
                            }
                            
                            try? moc.save()
                        }
                    )
                }
                
                Spacer()
                
                Button("Save Settings", action: {
                    appStorages[0].seed = seed
                    
                    for(_, folio) in folios.enumerated() {
                        if(folio.edited == false) {
                            print("Deleting \(folio.firstName)")
                            moc.delete(folio)
                        }
                    }
                    
                    try? moc.save()
                }).padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.indigo)
                    .background(Blur(style: .systemUltraThinMaterial))
                    .cornerRadius(10)
                    .padding([.horizontal, .bottom])
                
            }.padding([.horizontal])
            .onAppear {
                if appStorages.isEmpty {
                    let _ = AppStorage(context: moc)
                    try? moc.save()
                } else {
                    seed = appStorages[0].seed
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct TextInputCard: View {
    var label: String
    var placeholder: String
    
    @State var text: Binding<String>
    
    var body: some View {
            HStack {
                Text(label)
                TextField(placeholder, text: text)
                    .foregroundColor(.black)
                    .textFieldStyle(.roundedBorder)
                    .opacity(0.6)
            }
            .padding()
            .background(Blur(style: .systemUltraThinMaterial))
            .cornerRadius(10)
    }
}


struct ButtonAlertAction: View {
    
    @State private var showingAlert = false
    
    var label: String
    var icon: String
    
    var alertTitle: String
    var alertMessage: String
    var alertPrimaryButton: String
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            showingAlert = true
        }) {
            
            HStack {
                Text(label)
                Image(systemName: icon)
                    .font(Font.title.weight(.light))
                    .scaleEffect(0.7)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Blur(style: .systemUltraThinMaterial))
            .cornerRadius(10)
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                primaryButton: .destructive(Text(alertPrimaryButton)) {
                    action()
                },
                secondaryButton: .cancel()
            )
        }
    }
}
