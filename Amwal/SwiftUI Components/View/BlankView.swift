//
//  BlankView.swift
//  RER
//
//  Created by Maha Alsharikh on 22/04/2024.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        Text("")
            .frame(width: 0, height: 0)
            .hidden()
    }
}

#Preview {
    BlankView()
}
