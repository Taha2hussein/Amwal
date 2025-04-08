//
//  BlurEffect.swift
//  RER
//
//  Created by Maha Alsharikh on 27/02/2024.
//

import SwiftUI

struct BackgroundBlurView: UIViewRepresentable {
    var blurEffect : UIBlurEffect = UIBlurEffect(style: .dark)
    var backgroundColor : UIColor = UIColor(Color.black.opacity(0.9))
    var alpha = 0.70
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: blurEffect)
        view.backgroundColor = backgroundColor
        view.alpha = alpha
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
