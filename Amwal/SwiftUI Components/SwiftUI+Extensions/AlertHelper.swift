//
//  AlertHelper.swift
//  Dawak
//
//  Created by Taha Hussein on 05/03/2025.
//

import Foundation
import SwiftUI

struct CustomAlertView: View {
    var title: String
    var message: String
    var okayTitle: String
    var leftButtonBackgroundColor: Color
    var leftButtonTitleColor: Color
    var iconName: String
    var okAction: (() -> Void)?

    @Binding var isPresented: Bool

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)

                VStack(spacing: 16) {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.yellow)

                    Text(title)
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    Button(action: {
                        isPresented = false
                        okAction?()
                    }) {
                        Text(okayTitle)
                            .font(.headline)
                            .foregroundColor(leftButtonTitleColor)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(leftButtonBackgroundColor)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .padding(40)
            }
        }
    }
}

struct CustomAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var title: String
    var message: String
    var okayTitle: String = "OK"
    var leftButtonBackgroundColor: Color = Color.yellow
    var leftButtonTitleColor: Color = Color.blue
    var iconName: String = "exclamationmark.triangle.fill"
    var okAction: (() -> Void)?

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                CustomAlertView(
                    title: title,
                    message: message,
                    okayTitle: okayTitle,
                    leftButtonBackgroundColor: leftButtonBackgroundColor,
                    leftButtonTitleColor: leftButtonTitleColor,
                    iconName: iconName,
                    okAction: okAction,
                    isPresented: $isPresented
                )
            }
        }
    }
}

extension View {
    func customAlert(isPresented: Binding<Bool>, title: String, message: String, okayTitle: String = "OK", leftButtonBackgroundColor: Color = Color.yellow, leftButtonTitleColor: Color = Color.blue, iconName: String = "exclamationmark.triangle.fill", okAction: (() -> Void)? = nil) -> some View {
        self.modifier(CustomAlertModifier(isPresented: isPresented, title: title, message: message, okayTitle: okayTitle, leftButtonBackgroundColor: leftButtonBackgroundColor, leftButtonTitleColor: leftButtonTitleColor, iconName: iconName, okAction: okAction))
    }
}
