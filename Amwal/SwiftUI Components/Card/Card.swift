//
//  Card.swift
//  RER
//
//  Created by Maha Alsharikh on 20/12/1444 AH.
//

import SwiftUI

struct Card<Content: View>: View {
    var title: String? = nil
    var titleFont: Font = .RERBody.bold
    var titleColor: Color = .RERtext.dimmed
    var verticalPadding: CGFloat = 0
    var horizontalPadding: CGFloat = .Spacing.xs_Space
    @ViewBuilder let content: Content
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }.padding(.vertical, verticalPadding).padding(.horizontal, horizontalPadding).background(Color.primary)
            .cornerRadius(8)
            .if(title != nil) { view in
                view.sectionTitle(title: title!)
            }
    }
}
