//
//  NoDataView.swift
//  RER
//
//  Created by Maha Alsharikh on 08/02/1445 AH.
//

import SwiftUI

struct NoDataView: View {
    var text : String = "noData"
    var verticalPadding: CGFloat = .Spacing.xl_Space
    
    var body: some View {
        Card(verticalPadding: verticalPadding) {
            Text(text)
                .font(.RERBody.regular)
                .foregroundColor(.RERtext.dimmed)
//                .padding(.bottom, .Spacing.m)
                .frame(maxWidth: .infinity)
        }
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView(text: "noData")
    }
}
