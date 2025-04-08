//
//  Country.swift
//  Dawak
//
//  Created by Taha Hussein on 26/02/2025.
//

import SwiftUI
struct Country: Identifiable, Codable {
    var id = UUID()
    var name: String
    var dialCode: String
    var code: String
    var flag: String
    init(id: UUID = UUID(), name: String, dialCode: String, code: String, flag: String) {
        self.id = id
        self.name = name
        self.dialCode = dialCode
        self.code = code
        self.flag = flag
    }
    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case code
        case flag
    }
}
