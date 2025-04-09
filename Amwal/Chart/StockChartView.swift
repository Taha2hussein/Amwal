//
//  StockChartView.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//


//History(price: Optional(11302.76), date: Optional("2025-04-08T00:00:00"))
//    History(price: Optional(11395.51), date: Optional("2025-04-08T11:58:51.798428"))
import SwiftUI
import Charts

struct StockChartView: View {
    @ObservedObject var viewModel: StocksViewModel
    var parsedStocks: [(date: Date, price: Double)] {
        guard let history = viewModel.historyList?.history else { return [] }

        let formats = [
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd"
        ]

        return history.compactMap { item in
            guard let price = item.price, var dateString = item.date else {
                return nil
            }

            // If dateString contains a microsecond part, trim to milliseconds (3 digits)
            if let dotRange = dateString.range(of: "\\.\\d{4,6}", options: .regularExpression) {
                let fractional = dateString[dotRange]
                let trimmedFractional = String(fractional.prefix(4)) // keep .SSS
                dateString.replaceSubrange(dotRange, with: trimmedFractional)
            }

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")

            for format in formats {
                formatter.dateFormat = format
                if let date = formatter.date(from: dateString) {
                    return (date: date, price: price)
                }
            }

            print("⚠️ Could not parse date: \(dateString)")
            return nil
        }
    }

    var body: some View {
        if let start = parsedStocks.map(\.date).min(),
           let end = parsedStocks.map(\.date).max(),
           start <= end,
           viewModel.lowestValue <= viewModel.highestValue {
            
            ChartContent
                .frame(height: 150)
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
            Text("No chart data available")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .multilineTextAlignment(.center)
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
                        Text("\(Int(viewModel.historyList?.prev_close ?? 0.0))")
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
