//
//  TimeLabelsView.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import Foundation
import SwiftUI

struct TimeLabelsView: View {
    let labels: [String]

    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                ForEach(labels, id: \.self) { label in
                    Text(label)
                        .font(.RERBody.meduim)
                        .foregroundStyle(Color.success)
                        .frame(width: geo.size.width / CGFloat(labels.count))
                        .padding(.vertical, 5)
                }
            }
        }
        .frame(height: 30)
    }
}
