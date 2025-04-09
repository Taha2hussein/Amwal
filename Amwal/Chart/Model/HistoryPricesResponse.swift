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
    var vol_traded: Int?
    var change, high, low, open: Double?
    var prev_close: Double?
    var period_start_date: String?
    var market_closing_time: String?
}

// MARK: - History
struct History: Decodable {
    var price: Double?
    var date: String?
}
