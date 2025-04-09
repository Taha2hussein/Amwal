//
//  MovieRepository.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Combine
import Foundation

protocol AmwalRepository {
    func fetchHistoryPrices(period: String) -> AnyPublisher<HistoryPricesResponse, APIError>
    func fetchAnnouncment(page: Int) -> AnyPublisher<[AnnouncmentResponseElement], APIError>
  
}

protocol HasAmwalRepository {
    var amwalRepository: AmwalRepository { get }
}
