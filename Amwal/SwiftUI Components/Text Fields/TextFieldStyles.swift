//
//  TextFieldStyles.swift
//  RER
//
//  Created by Maha Alsharikh on 16/12/1444 AH.
//

import Foundation
import SwiftUI

struct PrimaryTextFieldStyle: TextFieldStyle {
    var height: CGFloat = 44
    var borderColor: Color = .clear
    var isDisabled: Bool = false
    var topPadding: CGFloat = 18
    var bottomPadding: CGFloat = .Spacing.xs3_Space
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .multilineTextAlignment(.leading)
            .padding(.horizontal, .Spacing.xs_Space)
            .padding(.top, topPadding)
            .padding(.bottom, bottomPadding)
            .font(.RERBody.meduim)
            .foregroundColor(.RERtext.primary)

            .background(isDisabled ? Color.disabled : Color.primary)
            .cornerRadius(.RERRadius.m_Raduis)
            .overlay(
                RoundedRectangle(cornerRadius: .RERRadius.m_Raduis)
                    .stroke(borderColor, lineWidth: 0.5)
            )
            
            
    }
}
