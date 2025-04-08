//
//  ChartViewModel.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import Foundation
import SwiftUI

final class StocksViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var selectedDate: Date?
    @Published var selectedStockValue: Int?
    @Published var selectedTimeRange: String = "1D"
    @Published var timeRangeList: [String] = []
    @Published var percentage: String = "298.42 (4.49%)"
    @Published var opened: String = "مغلق"
 
    let rangeOptions: [String] = ["1D", "5D", "1M", "3M", "6M", "YTD", "1Y", "5Y", "ALL"]
    private let chartColor: Color = Color.main
    @State  var selectedIndex = 0
    
    let startTime = 10
    let lastTime = 15

    init() {
        stocks = Stock.getData()
        updateTimeRangeList()
    }

    var chartColorValue: Color {
        chartColor
    }

    var highestValue: Int {
        stocks.max(by: { $0.value < $1.value })?.value ?? 4000
    }

    var lowestValue: Int {
        stocks.min(by: { $0.value < $1.value })?.value ?? 7000
    }

    var chartHeight: CGFloat {
        CGFloat(highestValue - lowestValue) * 0.1
    }

    var middlePoint: (date: Date, value: Double)? {
        let totalValue = stocks.map { $0.value }.reduce(0, +)
        let middleValue = Double(totalValue) / Double(stocks.count)

        if let closest = stocks.min(by: { abs(Double($0.value) - middleValue) < abs(Double($1.value) - middleValue) }) {
            return (closest.date, Double(closest.value))
        }
        return nil
    }

    var yesterdayCloseValue: Double {
        return 234234.0
    }
    
    func updateTimeRangeList() {
        let currentDate = Date()

        switch selectedTimeRange {
        case "1D":
            timeRangeList = generateHourlyIntervals(for: currentDate)
        case "5D":
            timeRangeList = generateLastNDays(from: currentDate, n: 5)
        case "1M":
            timeRangeList = generateMonthIntervals(for: currentDate)
        case "3M":
            timeRangeList = generateMonthsIntervals(from: currentDate, monthsBack: 3)
        case "6M":
            timeRangeList = generateMonthsIntervals(from: currentDate, monthsBack: 6)
        case "YTD":
            timeRangeList = generateYearToDateIntervals(for: currentDate)
        case "1Y":
            timeRangeList = generateLastYearIntervals(for: currentDate)
        case "5Y":
            timeRangeList = generateYearIntervals(for: currentDate, yearsBack: 5)
        case "ALL":
            timeRangeList = generateAllYearIntervals(for: currentDate, yearsBack: 30)
        default:
            timeRangeList = []
        }
    }

    func updateSelectedValue(for date: Date) {
        selectedStockValue = stocks.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) })?.value
    }

    // MARK: - Time Range Helpers
    private func generateHourlyIntervals(for date: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return (startTime...lastTime).compactMap { hour in
            Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: date).map { formatter.string(from: $0) }
        }
    }

    private func generateLastNDays(from date: Date, n: Int) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        return (0..<n).compactMap { offset in
            Calendar.current.date(byAdding: .day, value: -offset, to: date).map { formatter.string(from: $0) }
        }
    }


    private func generateMonthIntervals(for date: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM" // Example: "5 Apr", "1 Apr"

        let totalDays = 30
        let numberOfPoints = 6
        let interval = totalDays / numberOfPoints

        return (0..<numberOfPoints).compactMap { i in
            let daysAgo = i * interval
            if let targetDate = Calendar.current.date(byAdding: .day, value: -daysAgo, to: date) {
                return formatter.string(from: targetDate)
            }
            return nil
        }
    }


    private func generateMonthsIntervals(from date: Date, monthsBack: Int) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        
        return (0..<monthsBack).compactMap { offset in
            Calendar.current.date(byAdding: .month, value: -offset, to: date).map { formatter.string(from: $0) }
        }
    }


    private func generateYearToDateIntervals(for date: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        let monthCount = Calendar.current.component(.month, from: date)
        return (0..<monthCount).compactMap { offset in
            Calendar.current.date(byAdding: .month, value: -offset, to: date).map { formatter.string(from: $0) }
        }
    }

    private func generateLastYearIntervals(for date: Date, monthsBack: Int = 12, interval: Int = 2) -> [String] {
        let formatter = DateFormatter()
          formatter.dateFormat = "MMM"
          return (0..<monthsBack / interval).compactMap { offset in
              Calendar.current.date(byAdding: .month, value: -offset * interval, to: date).map {
                  formatter.string(from: $0)
              }
          }
    }

    
    private func generateYearIntervals(for date: Date, yearsBack: Int = 1) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return (0..<yearsBack).compactMap { offset in
            Calendar.current.date(byAdding: .year, value: -offset, to: date).map { formatter.string(from: $0) }
        }
    }
    
    private func generateAllYearIntervals(for date: Date, yearsBack: Int, interval: Int = 5) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        return (0..<yearsBack / interval).compactMap { offset in
            Calendar.current.date(byAdding: .year, value: -offset * interval, to: date).map {
                formatter.string(from: $0)
            }
        }
    }

}
