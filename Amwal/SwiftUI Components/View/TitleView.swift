//
//  TitleView.swift
//  RER
//
//  Created by sara alhammad on 01/11/2023.
//

import SwiftUI
struct TitleView: View {
    var title: String
    var subTitle: String
    var showRefrenceNumber: Bool = false
    var refrenceNumber: String? = nil
   
    
    var body: some View {
        VStack(alignment: .center){
                Text(title)
                    .font(.RERTitles.title1)
                    .foregroundColor(.RERtext.primary)
                    .padding(.vertical, .Spacing.xs2_Space)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

            Text(subTitle)
                .font(.RERBody.regular)
                .foregroundColor(.RERtext.secondary)
                .padding(.bottom, .Spacing.m_Space)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        
    }
}

#Preview {
    TitleView( title: "title", subTitle: "this is a sub title")
}
