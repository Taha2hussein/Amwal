//
//  ButtonStyles.swift
//  RER
//
//  Created by Maha Alsharikh on 16/12/1444 AH.
//

import Foundation
import SwiftUI

struct RERPrimaryButtonStyle: ButtonStyle {
    var width: CGFloat = .infinity
    var height: CGFloat = .Spacing.m_Space
    var font: Font = .RERBody.bold
    var color: Color = Color.actionPrimary
    var selectedColor: Color = Color.primary // Color when the button is selected
    var unselectedColor: Color = Color.secondary // Color when the button is not selected
    var radius: CGFloat = .RERRadius.xl2_Raduis
    var isSelected: Bool = false 
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: width, minHeight: height, maxHeight: height, alignment: .center)
            .background(isSelected ? selectedColor : unselectedColor)
            .foregroundColor(isSelected ? Color.main : Color.alert) // Update the foreground color based on selection
            .cornerRadius(radius)
            .font(font)
            .opacity(configuration.isPressed ? 0.8 : 1.0) // Add press effect
         
    }
}


//
struct RERSecondaryButtonStyle: ButtonStyle {
    var width: CGFloat = .infinity
    var height: CGFloat = .Spacing.xl_Space
    var font: Font = .RERBody.meduim
    var color: Color = .RERtext.main
    var borderColor: Color = .RERborder.actionPrimary
    var radius: CGFloat = .RERRadius.m_Raduis
    var backgroundColor: Color = .clear
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: width, minHeight: height, maxHeight: height, alignment: .center)
            .background(backgroundColor)
            .foregroundColor(color)
            .font(font)
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

struct RERPlainTextButtonStyle: ButtonStyle {
    var font: Font = .RERCaption1.semi
    var backgroundColor: Color = .clear
    var textColor: Color = .RERtext.actionSecondary
    var alignment: Alignment = .center
    var padding: CGFloat = 2
    var height: CGFloat = 42
    var width: CGFloat = 90
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, padding)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .font(font)
            .foregroundColor(textColor)
            .frame(width: width, height: height, alignment: alignment)
    }
}

struct RERAttachmentButtonStyle: ButtonStyle {
    var width: CGFloat = .infinity
    var height: CGFloat = 52
    var font: Font = .RERBody.regular
    var textColor: Color = .RERtext.secondary
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, .Spacing.xs3_Space)
            .padding(.horizontal, .Spacing.xs_Space)
            .frame(maxWidth: width, minHeight: height, maxHeight: height)
            .background(Color.primary)
            .foregroundColor(textColor)
            .font(font)
            .cornerRadius(.RERRadius.m_Raduis)

    }
}

struct RERPickerButtonStyle: ButtonStyle {
    var width: CGFloat = .infinity
    var height: CGFloat = 52
    var font: Font = .RERBody.meduim
    var color: Color = .RERtext.primary
    var borderColor: Color = .clear
    var isDisabled: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: width/*, minHeight: height, maxHeight: height*/)
            .frame(height: height)
            .foregroundColor(color)
            .padding(.horizontal, .Spacing.xs_Space)
//            .padding(.vertical, .Spacing.xs_3)
            .background(isDisabled ? Color.disabled : Color.primary)
            
            .font(font)
            .cornerRadius(.RERRadius.m_Raduis)
            .overlay(
                RoundedRectangle(cornerRadius: .RERRadius.m_Raduis)
                    .stroke(borderColor, lineWidth: 0.5)
            )
    }
}

struct RERMenuButtonStyle: MenuStyle {
    var width: CGFloat = .infinity
    var height: CGFloat = 44
    var font: Font = .RERBody.meduim
    var color: Color = .RERtext.primary
    var borderColor: Color = .clear
    var isDisabled: Bool = false
    
    
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .frame(maxWidth: width, minHeight: height, maxHeight: height)
            .foregroundColor(color)
            .padding(.horizontal, .Spacing.xs_Space)
            .padding(.vertical, .Spacing.xs3_Space)
            .background(isDisabled ? Color.disabled : Color.primary)
            .font(font)
            .cornerRadius(.RERRadius.m_Raduis)
            .overlay(
                RoundedRectangle(cornerRadius: .RERRadius.m_Raduis)
                    .stroke(borderColor, lineWidth: 0.5)
            )
    }
}

struct RERMenuLabelStyle: LabelStyle {
    var font: Font = .RERBody.meduim
    var color: Color = .RERtext.primary
    var backgroundColor: Color = Color.info
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .foregroundColor(color)
            .background(backgroundColor)
            .font(font)
    }
}
