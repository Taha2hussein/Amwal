//
//  StockChartView.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import SwiftUI
import Charts

//struct StockChartView: View {
//    @ObservedObject var viewModel: StocksViewModel
//    
//    var body: some View {
//        Chart {
//            ForEach(viewModel.stocks) { stock in
//
//                AreaMark(
//                    x: .value("Date", stock.date, unit: .day),
//                    yStart: .value("Stock Price", stock.value),
//                    yEnd: .value("Stock Price", 4000)
//                )
//                .interpolationMethod(.catmullRom)
//                .foregroundStyle(.linearGradient(
//                    colors: [viewModel.chartColorValue.opacity(0.3), viewModel.chartColorValue.opacity(0.04)],
//                    startPoint: .top,
//                    endPoint: .bottom
//                ))
//
//                // Make the curve line thinner by reducing lineWidth
//                LineMark(
//                    x: .value("Date", stock.date, unit: .day),
//                    y: .value("Stock Price", stock.value)
//                )
//                .foregroundStyle(viewModel.chartColorValue)
//                .lineStyle(StrokeStyle(lineWidth: 1)) // Adjust the line width here for a thinner curve
//
//                if let selectedDate = viewModel.selectedDate,
//                   let selectedStockValue = viewModel.selectedStockValue {
//                    RuleMark(x: .value("Date", selectedDate))
//                        .foregroundStyle(viewModel.chartColorValue)
//                        .annotation(position: .top) {
//                            Text("\(selectedStockValue)")
//                                .font(.caption)
//                                .foregroundColor(viewModel.chartColorValue)
//                        }
//                }
//            }
//            
//            if let middle = viewModel.middlePoint {
//                RuleMark(y: .value("Mid", middle.value))
//                    .foregroundStyle(Color.alert)
//                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
//                    .annotation(position: .top) {
//                        Text("\(Int(viewModel.yesterdayCloseValue))")
//                            .font(.RERBody.regular)
//                            .foregroundStyle(Color.actionSecondary)
//                            .padding(5)
//                            .background(Color.alert)
//                            .cornerRadius(6)
//                            .offset(x: -160, y: 15)
//                    }
//            }
//        }
//        .frame(height: viewModel.chartHeight)
//        .chartXScale(domain: Date(year: 2024, month: 1, day: 1)...Date(year: 2024, month: 1, day: 31))
//        .chartYScale(domain: viewModel.lowestValue...viewModel.highestValue)
//        .chartXAxis(.hidden)
//        .chartYAxis(.hidden)
//        .chartXSelection(value: $viewModel.selectedDate)
//        .chartGesture { proxy in
//            DragGesture(minimumDistance: 0)
//                .onChanged { proxy.selectXValue(at: $0.location.x) }
//                .onEnded { _ in
//                    viewModel.selectedDate = nil
//                    viewModel.selectedStockValue = nil
//                }
//        }
//        .padding(0) // Remove padding
//        .onChange(of: viewModel.selectedDate) { newValue in
//            if let newValue {
//                viewModel.updateSelectedValue(for: newValue)
//            }
//        }
//    }
//}


//struct StockChartView: View {
//    @ObservedObject var viewModel: StocksViewModel
//
//    var parsedStocks: [(date: Date, price: Double)] {
//        guard let history = viewModel.historyList?.history else { return [] }
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
//
//        return history.compactMap { item in
//            guard
//                let price = item.price,
//                let dateString = item.date,
//                let date = formatter.date(from: dateString)
//            else {
//                print("⚠️ Could not parse date: \(item.date ?? "nil")")
//                return nil
//            }
//
//            return (date: date, price: price)
//        }
//    }
//
//
//    var body: some View {
//        if !parsedStocks.isEmpty {
//            ChartContent
//                .frame(height: viewModel.chartHeight)
//            
//                .chartXScale(domain: (parsedStocks.first?.date ?? Date())...((parsedStocks.last?.date ?? Date())))
//                .chartYScale(domain: viewModel.highestValue...viewModel.lowestValue)
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
//                .chartXSelection(value: $viewModel.selectedDate)
//                .chartGesture { proxy in
//                    DragGesture(minimumDistance: 0)
//                        .onChanged { proxy.selectXValue(at: $0.location.x) }
//                        .onEnded { _ in
//                            viewModel.selectedDate = nil
//                            viewModel.selectedStockValue = nil
//                        }
//                }
//                .padding(0)
//                .onChange(of: viewModel.selectedDate) { newDate in
//                    if let newDate {
//                        viewModel.updateSelectedValue(for: newDate)
//                    }
//                }
//        } else {
//            Text("No chart data available")
//                .frame(height: 150)
//                .frame(maxWidth: .infinity)
//                .multilineTextAlignment(.center)
//                .foregroundColor(.gray)
//                .background(Color(.systemGroupedBackground))
//                .cornerRadius(12)
//                .padding()
//        }
//    }
//
//    @ViewBuilder
//    var ChartContent: some View {
//        Chart {
//            let lineColor = viewModel.chartColorValue
//            let startPrice = viewModel.lowestValue
//
//            ForEach(parsedStocks, id: \.date) { stock in
//                let endPrice = stock.price
//                let date = stock.date
//
//                AreaMark(
//                    x: .value("Date", date),
//                    yStart: .value("Price", startPrice),
//                    yEnd: .value("Price", endPrice)
//                )
//                .interpolationMethod(.catmullRom)
//                .foregroundStyle(
//                    .linearGradient(
//                        colors: [
//                            lineColor.opacity(0.3),
//                            lineColor.opacity(0.04)
//                        ],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                )
//
//                LineMark(
//                    x: .value("Date", date),
//                    y: .value("Price", endPrice)
//                )
//                .foregroundStyle(lineColor)
//                .lineStyle(StrokeStyle(lineWidth: 1))
//            }
//        }
//    }
//}


//History(price: Optional(11302.76), date: Optional("2025-04-08T00:00:00"))
//    History(price: Optional(11395.51), date: Optional("2025-04-08T11:58:51.798428"))
import SwiftUI
import Charts

struct StockChartView: View {
    @ObservedObject var viewModel: StocksViewModel

    var parsedStocks: [(date: Date, price: Double)] {
        guard let history = viewModel.historyList?.history else { return [] }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"

        return history.compactMap { item in
            guard
                let price = item.price,
                let dateString = item.date,
                let date = formatter.date(from: dateString)
            else {
                print("⚠️ Could not parse date: \(item.date ?? "nil")")
                return nil
            }

            return (date: date, price: price)
        }
    }
  
    var body: some View {
        if let start = parsedStocks.map(\.date).min(),
           let end = parsedStocks.map(\.date).max(),
           start <= end,
           viewModel.lowestValue <= viewModel.highestValue {

            ChartContent
                .frame(height: viewModel.chartHeight)
                .clipped()
                .chartXScale(domain: start...end)
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
                .onChange(of: viewModel.selectedDate) { newDate in
                    if let newDate {
                        viewModel.updateSelectedValue(for: newDate)
                    }
                }

        } else {
            VStack {
                Spacer()
                Text("No chart data available")
                    .foregroundColor(.gray)
                Spacer()
            }
            .frame(height: 150)
        }
    }

    @ViewBuilder
    var ChartContent: some View {
        Chart {
            let lineColor = viewModel.chartColorValue
            let startPrice = viewModel.lowestValue

            ForEach(parsedStocks, id: \.date) { stock in
                let endPrice = stock.price
                let date = stock.date

                AreaMark(
                    x: .value("Date", date),
                    yStart: .value("Price", startPrice),
                    yEnd: .value("Price", endPrice)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    .linearGradient(
                        colors: [
                            lineColor.opacity(0.3),
                            lineColor.opacity(0.04)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                LineMark(
                    x: .value("Date", date),
                    y: .value("Price", endPrice)
                )
                .foregroundStyle(lineColor)
                .lineStyle(StrokeStyle(lineWidth: 1))
            }

            if let middle = viewModel.middlePoint {
                RuleMark(y: .value("Mid", middle.value))
                    .foregroundStyle(Color.alert)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
                    .annotation(position: .top) {
                        Text("\(Int(viewModel.historyList?.prevClose ?? 0.0))")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                            .padding(5)
                            .background(Color.alert)
                            .cornerRadius(6)
                            .offset(x: -160, y: 15)
                    }
            }
        }
    }
}
