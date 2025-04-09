//
//  Client.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Combine
import Foundation

protocol Client {
    func performRequest<T: Decodable>(
        api: APIEndpoint,
        decodeTo: T.Type
    ) -> AnyPublisher<T, APIError>
    
    func performRequest(
        api: APIEndpoint
    ) -> AnyPublisher<Data, APIError>
}

protocol HasClient {
    var client: Client { get }
}
