//
//  GenericAPIResponse.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Foundation

struct GenericAPIResponse<T: Codable>: Codable {
    let result: Response<T>?
}

struct Response<T: Codable>: Codable {
    let status: Bool?
    let data: T?
}

