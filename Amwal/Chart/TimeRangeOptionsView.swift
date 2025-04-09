//
//  TimeRangeOptionsView.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import Foundation
import SwiftUI

struct TimeRangeOptionsView: View {
    @ObservedObject var viewModel: StocksViewModel

    var body: some View {
        HStack {
            ForEach(viewModel.rangeOptions, id: \.self) { option in
                Button(action: {
                    viewModel.selectedTimeRange = option
                    viewModel.updateTimeRangeList()
                    viewModel.fetchHistoryList()
                }) {
                    Text(option.rawValue)
                        .foregroundColor(viewModel.selectedTimeRange == option ? viewModel.chartColorValue : Color.alert)
                        .padding(.horizontal,7)
                        .padding(.vertical,7)
                        .background(viewModel.selectedTimeRange == option ? Color.primary : Color.grays)
                        .cornerRadius(10)
                        .font(.RERBody.regular)
                }
                .padding(2)
            }
        }
    }
}
