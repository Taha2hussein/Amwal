//
//  HistoryPricesResponse.swift
//  Amwal
//
//  Created by Taha Hussein on 09/04/2025.
//

import Foundation
// MARK: - HistoryPricesResponse
struct HistoryPricesResponse: Decodable {
    var history: [History]?
    var volTraded: Int?
    var change, high, low, historyPricesResponseOpen: Double?
    var prevClose: Double?
    var periodStartDate: String?
//    var marketClosingTime: NSNull?
}

// MARK: - History
struct History: Decodable {
    var price: Double?
    var date: String?
}
