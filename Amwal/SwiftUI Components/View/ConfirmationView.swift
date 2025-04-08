//
//  ConfirmationView.swift
//  RER
//
//  Created by Maha Alsharikh on 18/12/2023.
//

import SwiftUI

struct ConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let subTitle: String?
    let okButtonTitle: String
    let cancelButtonTitle: String?
    let onOk: () -> ()
    let onCancel: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.RERTitles.title3).foregroundStyle(Color.RERtext.primary).padding(.bottom, 4)
            if let subTitle = subTitle {
                Text(subTitle).font(.RERBody.regular).foregroundStyle(Color.RERtext.primary).padding(.top, 4)
            }
            
            HStack(spacing: .Spacing.xs2_Space) {
                Button {
                    dismiss()
                    onOk()
                } label: {
                    Text(okButtonTitle)
                }.buttonStyle(RERSecondaryButtonStyle(color: .RERtext.primary, borderColor: .RERborder.invert))
                
                Button {
                    dismiss()
                    onCancel()
                } label: {
                    Text(cancelButtonTitle ?? "cancel")
                }.buttonStyle(RERSecondaryButtonStyle(color: .RERtext.warning, borderColor: .RERborder.warning))
            }.padding(.top, .Spacing.m_Space)
        }.padding(.vertical, 48).padding(.horizontal, 15).background(Color.secondary)
    }
}


#Preview {
    ConfirmationView(title: "title", subTitle: "subTitle", okButtonTitle: "okButtonTitle", cancelButtonTitle: "cancel", onOk: {}, onCancel: {})
}
