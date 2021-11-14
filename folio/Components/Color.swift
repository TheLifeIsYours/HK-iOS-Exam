//
//  Color.swift
//  folio
//
//  Created by Mats Daniel Larsen on 11/11/2021.
//

import Foundation
import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

var PurpleGradient: some View {
    LinearGradient(gradient: Gradient(colors: [.purple, .indigo]), startPoint: .bottomLeading, endPoint: .top)
}
