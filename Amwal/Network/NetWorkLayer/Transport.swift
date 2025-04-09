//
//  Transport.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Combine
import Foundation

protocol Transport {
    func send(endPoint: APIEndpoint) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error>
}
