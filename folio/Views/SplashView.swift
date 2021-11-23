//
//  SplashView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 23/11/2021.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            PurpleGradient
            
            VStack {
                
                Spacer()
                Spacer()
                
                Image("folio_transparent")
                    .resizable()
                    .opacity(0.6)
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                Text("FOLIO")
                
                Spacer()
            }
        }
        .font(.custom("Lato-Light", size: 18))
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}
