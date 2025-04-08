//
//  TextExtension.swift
//  RER
//
//  Created by Maha Alsharikh on 16/04/1445 AH.
//

import Foundation
import SwiftUI

extension Text {
    func isRequired() -> some View {
        return HStack(spacing: 2) {
            self
            Text("*").foregroundStyle(Color.RERtext.warning).offset(y: -2)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
