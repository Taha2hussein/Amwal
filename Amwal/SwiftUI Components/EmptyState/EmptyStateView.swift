//
//  EmptyStateView.swift
//  RER
//
//  Created by sara alhammad on 05/11/2023.
//

import SwiftUI

struct EmptyStateView: View {
    var icon: String?
    var systemIcon: Image? = nil
    var text: String
    var buttonText: String
    var buttonIcon: Image?
    var buttonAction: ()->() = {}
    var isButtonVisible: Bool = true
    var isPrimaryButtonStyle: Bool =  true
    
    var body: some View {
        VStack{
            if let systemIcon {
                systemIcon
                    .resizable()
                    .frame(width: 66, height: 66)
                    .padding(.vertical, .Spacing.xs_Space)
                    .foregroundColor(.RERicon.invert)
            } else {
                Image(icon ?? "")
                //                    .resizable()
                //                    .frame(width: 66, height: 76)
                    .padding(.vertical, .Spacing.xs2_Space)
            }
            Text(text)
                .font(.RERBody.regular)
                .foregroundColor(.RERtext.dimmed)
                .padding(.bottom, .Spacing.xs_Space)
            
            if isButtonVisible {
                Button {
                    buttonAction()
                } label: {
                    HStack {
                        if buttonIcon != nil {
                            buttonIcon
                        }
                        Text(buttonText)
                    }
                }.if(isPrimaryButtonStyle, transform: { view in
                    view.buttonStyle(RERPrimaryButtonStyle())
                })
                .if(!isPrimaryButtonStyle, transform: { view in
                    view.buttonStyle(RERSecondaryButtonStyle())
                })
                .padding(.horizontal, .Spacing.m_Space)
            }
        }
        .padding(.Spacing.l_Space)
        .background(Color.secondary)
        .cornerRadius(CGFloat.RERRadius.l_Raduis)
        
    }
}

#Preview {
    EmptyStateView(icon: "calendar_noFill", text: "text", buttonText: "button")
}
