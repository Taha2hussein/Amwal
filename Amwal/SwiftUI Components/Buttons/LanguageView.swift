//
//  LanguageSelectionView.swift
//  Dawak
//
//  Created by Taha Hussein on 12/03/2025.
//

import SwiftUI

struct LanguageView: View {
    var onSelect: (String) -> Void
    @State private var selectedLanguage: String = "English"

    var body: some View {
        HStack(spacing: 8) {
            TextButton(
                title: "English",
                textColor: selectedLanguage == "English" ? .blue : .gray,
                isUnderlined: false,
                alignment: .trailing,
                width: 90.0
            ) {
                selectedLanguage = "English"
                onSelect("English")
            }

            Text("|")
                .foregroundColor(.gray)

            TextButton(
                title: "العربية",
                textColor: selectedLanguage == "العربية" ? .primary : .gray,
                isUnderlined: false,
                alignment: .leading,
                width: 90.0
            ) {
                selectedLanguage = "العربية"
                onSelect("العربية")
            }
        }
    }
}
