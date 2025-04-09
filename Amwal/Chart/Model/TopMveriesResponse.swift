//
//  TopMveriesResponse.swift
//  Amwal
//
//  Created by Taha Hussein on 09/04/2025.
//

import Foundation
// MARK: - TopMveriesResponse
struct TopMveriesResponse: Decodable {
    var gainers, losers: [Gainer]?
}

// MARK: - Gainer
struct Gainer: Decodable {
    var ticker, name: String?
    var price, change: Double?
}
