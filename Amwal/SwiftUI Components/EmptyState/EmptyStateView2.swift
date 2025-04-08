//
//  EmptyStateView2.swift
//  RER
//
//  Created by Maha Alsharikh on 01/04/2024.
//

import SwiftUI

struct EmptyStateView2: View {
    var icon: Image?
    var iconColor: Color?
    var title: String?
    var text: String?
    var buttonText: String?
    var buttonIcon: Image?
    var buttonAction: ()->() = {}
    var isButtonVisible: Bool = true
    var isPrimaryButtonStyle: Bool =  true
    var spacing: CGFloat? = .Spacing.xs_Space
    
    var body: some View {
        Card(verticalPadding: .Spacing.l_Space) {
            VStack(spacing: spacing){
                if let icon {
                    icon
                        .renderingMode(.template)
                        .foregroundStyle(Color.RERicon.invert)
                }
                VStack(spacing: 0){
                    if let title {
                        Text(title)
                            .font(.RERBody.bold)
                            .foregroundColor(.RERtext.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    if let text {
                        Text(text)
                            .font(.RERCaption1.regular)
                            .foregroundColor(.RERtext.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                if isButtonVisible {
                    Button {
                        buttonAction()
                    } label: {
                        HStack {
                            if buttonIcon != nil {
                                buttonIcon
                            }
                            Text(buttonText ?? "")
                        }
                    }.if(isPrimaryButtonStyle, transform: { view in
                        view.buttonStyle(RERPrimaryButtonStyle())
                    })
                    .if(!isPrimaryButtonStyle, transform: { view in
                        view.buttonStyle(RERSecondaryButtonStyle(width: 108, height: .Spacing.m_Space, font: .RERCaption1.bold))
                    })
                    .padding(.horizontal, .Spacing.m_Space)
                }
            }
        }
    }
}
#Preview {
    EmptyStateView2(buttonText: "")
}
