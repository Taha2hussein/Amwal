//
//  StockChartView.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import SwiftUI
import Charts

struct StockChartView: View {
    @ObservedObject var viewModel: StocksViewModel
    
    var body: some View {
        Chart {
            ForEach(viewModel.stocks) { stock in

                AreaMark(
                    x: .value("Date", stock.date, unit: .day),
                    yStart: .value("Stock Price", stock.value),
                    yEnd: .value("Stock Price", 4000)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.linearGradient(
                    colors: [viewModel.chartColorValue.opacity(0.3), viewModel.chartColorValue.opacity(0.04)],
                    startPoint: .top,
                    endPoint: .bottom
                ))

                // Make the curve line thinner by reducing lineWidth
                LineMark(
                    x: .value("Date", stock.date, unit: .day),
                    y: .value("Stock Price", stock.value)
                )
                .foregroundStyle(viewModel.chartColorValue)
                .lineStyle(StrokeStyle(lineWidth: 1)) // Adjust the line width here for a thinner curve

                if let selectedDate = viewModel.selectedDate,
                   let selectedStockValue = viewModel.selectedStockValue {
                    RuleMark(x: .value("Date", selectedDate))
                        .foregroundStyle(viewModel.chartColorValue)
                        .annotation(position: .top) {
                            Text("\(selectedStockValue)")
                                .font(.caption)
                                .foregroundColor(viewModel.chartColorValue)
                        }
                }
            }
            
            if let middle = viewModel.middlePoint {
                RuleMark(y: .value("Mid", middle.value))
                    .foregroundStyle(Color.alert)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
                    .annotation(position: .top) {
                        Text("\(Int(viewModel.yesterdayCloseValue))")
                            .font(.RERBody.regular)
                            .foregroundStyle(Color.actionSecondary)
                            .padding(5)
                            .background(Color.alert)
                            .cornerRadius(6)
                            .offset(x: -160, y: 15)
                    }
            }
        }
        .frame(height: viewModel.chartHeight)
        .chartXScale(domain: Date(year: 2024, month: 1, day: 1)...Date(year: 2024, month: 1, day: 31))
        .chartYScale(domain: viewModel.lowestValue...viewModel.highestValue)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartXSelection(value: $viewModel.selectedDate)
        .chartGesture { proxy in
            DragGesture(minimumDistance: 0)
                .onChanged { proxy.selectXValue(at: $0.location.x) }
                .onEnded { _ in
                    viewModel.selectedDate = nil
                    viewModel.selectedStockValue = nil
                }
        }
        .padding(0) // Remove padding
        .onChange(of: viewModel.selectedDate) { newValue in
            if let newValue {
                viewModel.updateSelectedValue(for: newValue)
            }
        }
    }
}
