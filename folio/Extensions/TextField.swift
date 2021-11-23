//
//  TextField.swift
//  folio
//
//  Created by Mats Daniel Larsen on 23/11/2021.
//

import SwiftUI

extension TextField {
    
    func textFieldStyling(roundedCornes: CGFloat, color: Color, opacity: Double) -> some View {
        self
            .padding([.top, .bottom], 2)
            .padding(.horizontal, 4)
            .background(color.opacity(opacity))
            .cornerRadius(roundedCornes)
            .shadow(color: color, radius: 3)
    }
}
