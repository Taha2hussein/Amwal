//
//  ChartViewModel.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import Foundation
import SwiftUI
import Combine

enum SelectedTimeRange: String, CaseIterable, Identifiable {
    case oneDay = "1D"
    case fiveDays = "5D"
    case oneMonth = "1M"
    case threeMonths = "3M"
    case sixMonths = "6M"
    case yearToDate = "YTD"
    case oneYear = "1Y"
    case fiveYears = "5Y"
    case all = "ALL"

    var id: String { self.rawValue }
}


final class StocksViewModel: ObservableObject {
     @Published var selectedDate: Date?
     @Published var selectedStockValue: Double?
     @Published var selectedTimeRange: SelectedTimeRange = .oneDay
     @Published var timeRangeList: [String] = []
     @Published var percentage: String = "298.42 (4.49%)"
     @Published var opened: String = "مغلق"
     private var cancellables = Set<AnyCancellable>()
     var historyListPublisher: PassthroughSubject<Result<HistoryPricesResponse, APIError>, Never> = PassthroughSubject()
    @Published var historyList: HistoryPricesResponse?

     let rangeOptions: [SelectedTimeRange] = SelectedTimeRange.allCases
     private let chartColor: Color = Color.main
     let startTime = 10
     let lastTime = 15
    
    init() {
//        stocks = Stock.getData()
        updateTimeRangeList()
    }
    
    var chartColorValue: Color {
        chartColor
    }
    
    var highestValue: Double {
        historyList?.high ?? 0.0
    }

    var lowestValue: Double {
        historyList?.low ?? 0.0
    }

    
    var chartHeight: CGFloat {
        let delta = highestValue - lowestValue
        return max(CGFloat(delta), 100)
    }

    var middlePoint: (date: Date, value: Double)? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"

        let validStocks: [(date: Date, value: Double)] = historyList?.history?.compactMap { history in
            guard
                let price = history.price,
                let dateString = history.date,
                let date = formatter.date(from: dateString)
            else {
                return nil
            }
            return (date: date, value: price)
        } ?? []
        
        guard !validStocks.isEmpty else { return nil }
        
        let totalValue = validStocks.map { $0.value }.reduce(0, +)
        let middleValue = totalValue / Double(validStocks.count)
        
        if let closest = validStocks.min(by: { abs($0.value - middleValue) < abs($1.value - middleValue) }) {
            return (date: closest.date, value: closest.value)
        }
        
        return nil
    }


    var yesterdayCloseValue: Double {
        return historyList?.prevClose ?? 0.0
    }
    
    func updateTimeRangeList() {
        let currentDate = Date()
        
        switch selectedTimeRange {
        case .oneDay:
            timeRangeList = generateHourlyIntervals(for: currentDate)
        case .fiveDays:
            timeRangeList = generateLastNDays(from: currentDate, n: 5)
        case .oneMonth:
            timeRangeList = generateMonthIntervals(for: currentDate)
        case .threeMonths:
            timeRangeList = generateMonthsIntervals(from: currentDate, monthsBack: 3)
        case .sixMonths:
            timeRangeList = generateMonthsIntervals(from: currentDate, monthsBack: 6)
        case .yearToDate:
            timeRangeList = generateYearToDateIntervals(for: currentDate)
        case .oneYear:
            timeRangeList = generateLastYearIntervals(for: currentDate)
        case .fiveYears:
            timeRangeList = generateYearIntervals(for: currentDate, yearsBack: 5)
        case .all:
            timeRangeList = generateAllYearIntervals(for: currentDate, yearsBack: 30)
        }
        
    }
    
    func updateSelectedValue(for date: Date) {
        let formatter = ISO8601DateFormatter() // Or use DateFormatter if your format is custom

        selectedStockValue = historyList?.history?
            .compactMap { item -> (Date, Double)? in
                guard
                    let dateString = item.date,
                    let price = item.price,
                    let itemDate = formatter.date(from: dateString)
                else { return nil }
                return (itemDate, price)
            }
            .first(where: { Calendar.current.isDate($0.0, inSameDayAs: date) })?
            .1
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

extension StocksViewModel {
    
    func fetchHistoryList() {
        dependencies.amwalRepository.fetchHistoryPrices(period: self.selectedTimeRange.rawValue)
        
            .catch { error -> Just<HistoryPricesResponse> in
                print("Error fetching movies: \(error.localizedDescription)")
                self.historyListPublisher.send(.failure(.otherError(message: error.localizedDescription)))
                
                return Just(HistoryPricesResponse())
            }
        
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished fetching prices list.")
                case .failure:
                    break
                }
            }, receiveValue: { response in
                self.historyList = response
                self.historyListPublisher.send(.success(response))
                print(response)
            })
            .store(in: &cancellables)
    }
}
//https:api.amwal.hazaber.com/v0/prices/history/ix-tasi?period_id=1D
