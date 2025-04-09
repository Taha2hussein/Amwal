//
//  StatRow.swift
//  Amwal
//
//  Created by Taha Hussein on 09/04/2025.
//

import Foundation
import SwiftUI

struct StatItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
}

struct StatRow: View {
    let left: StatItem
    let right: StatItem

    var body: some View {
        HStack {
            HStack( spacing: 4) {
                Text(left.value)
                    .font(.RERBody.meduim)
                    .foregroundColor(.white)
                    Spacer()
                Text(left.title)
                    .font(.RERBody.meduim)
                    .foregroundColor(.white)
            }
            Spacer()
            Divider()
                .frame(height: 40)
                .background(Color.gray.opacity(0.5))
            Spacer()
            HStack( spacing: 4) {
                Text(right.value)
                    .font(.RERBody.meduim)
                    .foregroundColor(.white)
                Spacer()
                Text(right.title)
                    .font(.RERBody.meduim)
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 8)
    }
}
struct StockStatsView: View {
    let rows: [(StatItem, StatItem)] = [
        (
            StatItem(title: "صافي القيمة", value: "10,486.23"),
            StatItem(title: "الافتتاح", value: "11,931.70")
        ),
        (
            StatItem(title: "انخفاض ٥٢ اسبوع", value: "8,931.70"),
            StatItem(title: "ارتفاع ٥٢ اسبوع", value: "13,931.70")
        ),
        (
            StatItem(title: "صافي الحصول", value: "2,546M"),
            StatItem(title: "القيمة السوقية", value: "3,459M")
        ),
        (
            StatItem(title: "م. الكمية (٣ اشهر)", value: "46M"),
            StatItem(title: "الكمية", value: "59M")
        ),
        (
            StatItem(title: "عائد الأرباح", value: "1.19%"),
            StatItem(title: "السعر/الأرباح", value: "30.54")
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(rows.indices, id: \.self) { index in
                StatRow(left: rows[index].0, right: rows[index].1)

                if index < rows.count - 1 {
                    Divider()
                        .background(Color.gray.opacity(0.3))
                }
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(16)
    }
}
