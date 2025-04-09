//
//  AnnouncmentResponseElement.swift
//  Amwal
//
//  Created by Taha Hussein on 09/04/2025.
//

import Foundation
// MARK: - AnnouncmentResponseElement
struct AnnouncmentResponseElement: Decodable {
    var date, headline, details, url: String?
    var security: Security?

    private enum CodingKeys: String, CodingKey {
        case date, headline, details, url, security
    }
}

// MARK: - Security
struct Security: Decodable {
    var ticker, name: String?
    var price, change: Double?
    private enum CodingKeys: String, CodingKey {
        case ticker, name, price, change
    }
}
