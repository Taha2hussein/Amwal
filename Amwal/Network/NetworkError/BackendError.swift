//
//  BackendError.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Foundation

struct BackendError: Decodable, Equatable {
    let code: Int?
    let field: String?
    let errorDetails: String?
    
    enum CodingKeys: CodingKey {
        case code
        case field
        case errorDetails
    }
    
    init(code: Int?, field: String?, errorDetails: String?) {
        self.code = code
        self.field = field
        self.errorDetails = errorDetails
    }
    
    func getErrorMessage() -> String {
        _ = ErrorMessages.shared.errors
        if let frErrorMessage = ErrorMessages.shared.fRErrors[self.errorDetails ?? ""] {
            return   frErrorMessage.En
        } else if let code = self.code, let errorMessage = ErrorMessages.shared.errors[String(code)] {
            return errorMessage.En
        } else {
            return errorDetails ?? "generalError"
        }
    }
    
}

struct BackendErrors: Decodable, Equatable {
    let errors: [BackendError]
}


struct ErrorMessages {
    static let shared = ErrorMessages()
    var errors: [String:BackendErrorMessage] = [:]
    var fRErrors: [String:BackendErrorMessage] = [:]
    
    private init() {}

}

struct BackendErrorMessage: Codable {
    let Code: String
    let En: String
    let Ar: String
}

extension Sequence {
    public func toDictionary<K: Hashable, V>(_ selector: (Iterator.Element) throws -> (K, V)?) rethrows -> [K: V] {
        var dict = [K: V]()
        for element in self {
            if let (key, value) = try selector(element) {
                dict[key] = value
            }
        }
        return dict
    }
}
