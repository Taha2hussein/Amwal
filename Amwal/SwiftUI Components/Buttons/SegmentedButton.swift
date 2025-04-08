//
//  SegmentButton.swift
//  RER
//
//  Created by Maha Alsharikh on 01/01/2024.
//

import SwiftUI

struct SegmentedButton: View {
    @Binding var selectedId: Int?
    let dict: [Int: String]
    var body: some View {
        HStack{
            ForEach(dict.sorted(by: <), id: \.key) { key, value in
                VStack {
                    Text(value)
                        .foregroundStyle(isSelected(id: key) ? Color.RERtext.actionSecondary : Color.RERtext.secondary)
                        .font(.RERBody.meduim)
                }.frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(isSelected(id: key) ? Color.actionSecondary : Color.primary)
                    .padding(3)
                    .onTapGesture {
                        if selectedId != key {
                            selectedId = key
                        }
                    }
            }
        }.background(Color.primary)
            .cornerRadius(.RERRadius.m_Raduis)
    }
    func isSelected(id: Int) -> Bool {
        return id == selectedId
    }
}
