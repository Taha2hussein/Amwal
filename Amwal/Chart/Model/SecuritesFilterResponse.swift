//
//  SecuritesFilterResponse.swift
//  Amwal
//
//  Created by Taha Hussein on 09/04/2025.
//

import Foundation
struct SecuritesFilterResponseElement: Decodable, Identifiable {
    var id: String { ticker ?? UUID().uuidString }
    var ticker: String?
    var name_short_en: String?
    var alias_en, name_long_ar: String?
    var name_short_ar: String?
    var alias_ar: String?
    var type_id, sector_id, market_id: Int?
    var price, change, high, low: Double?
}
