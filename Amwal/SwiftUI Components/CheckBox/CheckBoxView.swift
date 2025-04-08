//
//  CheckBoxView.swift
//  Dawak
//
//  Created by Taha Hussein on 12/03/2025.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isOn: Bool
    let title: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(IOSCheckboxToggleStyle())
                .offset(y: 2)

            Spacer().frame(width: .Spacing.xs2_Space)

            Text(title)
                .font(.RERCaption1.semi)
                .foregroundColor(.RERtext.primary)
                .frame(alignment: .topLeading)
                .allowsHitTesting(false) // ⬅️ Prevent text from being interactive
        }
    }
}
struct IOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Image(configuration.isOn ? "checked.square" : "square")
            .resizable()
            .frame(width: .Spacing.xs_Space, height: .Spacing.xs_Space)
            .onTapGesture { // ⬅️ Ensure only the checkbox toggles the state
                configuration.isOn.toggle()
            }
    }
}
