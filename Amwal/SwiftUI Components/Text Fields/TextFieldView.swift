//
//  TextFieldView.swift
//  Dawak
//
//  Created by Taha Hussein on 26/02/2025.
//

import SwiftUI

struct TextFieldView: View {
    var title: String
    @Binding var text: String
    var isSecureField: Bool
    var showShadow: Bool
    @State private var isSecure: Bool

    init(title: String, text: Binding<String>, isSecureField: Bool = false, showShadow: Bool = false) {
        self.title = title
        self._text = text
        self.isSecureField = isSecureField
        self.showShadow = showShadow
        self._isSecure = State(initialValue: isSecureField)
    }

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(title)
                        .font(.RERBody.regular)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 10)
                        .background(Color.clear)
                } else {
                    Text(title)
                        .font(.RERBody.regular)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 0)
                        .padding(.top, 7)
                        .scaleEffect(0.85)
                        .offset(y: -22)
                        .animation(.easeInOut(duration: 0.2), value: text)
                }

                HStack {
                    if isSecureField && isSecure {
                        SecureField("", text: $text)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.vertical, 12)
                    } else {
                        TextField("", text: $text)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.vertical, 12)
                    }

                    if isSecureField {
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(10)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 1)
            )
            .shadow(color: showShadow ? Color.gray.opacity(0.2) : Color.clear, radius: showShadow ? 2 : 0, x: 0, y: 3)
        }
        .padding(.horizontal)
    }
}

func validateTextField(_ text: String?, validators: [TextFieldValidators]) -> String? {
    for validator in validators {
        switch validator {
        case .isRequired:
            if text == nil || text!.isEmpty {
                return validator.errorMessage
            }
        case .maxLength(let max):
            if ((text?.count ?? 0) > max) {
                return validator.errorMessage
            }
        case .minLength(let min):
            if (text?.count ?? 0) < min {
                return validator.errorMessage
            }
        case .customValidation(let regex):
            if let error = regex(text ?? "") {
                return error
            }
        }
    }
    return nil
}

enum TextFieldValidators {
    case isRequired
    case maxLength(Int)
    case minLength(Int)
    case customValidation((String) -> (String?))
    var errorMessage: String {
        switch self {
        case .isRequired:
            return "mandatoryField"
        case .maxLength(let max):
            return "maxLengthError".appendLocalizedString("\(max)")
        case .minLength(let min):
            return "minLengthError".appendLocalizedString("\(min)")
        case .customValidation(_):
            return ""
        }
    }
}
