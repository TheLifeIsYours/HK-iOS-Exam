//
//  ButtonAlert.swift
//  folio
//
//  Created by Mats Daniel Larsen on 23/11/2021.
//

import SwiftUI


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
