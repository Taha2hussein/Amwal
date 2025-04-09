//
//  MovieAPI.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Combine
import Foundation

struct AmwalAPI: AmwalRepository {
    
    let client: Client
    
    init(client: Client = moyaProvider) {
        self.client = client
    }
    
    func fetchHistoryPrices(period: String) -> AnyPublisher<HistoryPricesResponse, APIError> {
        return self.client.performRequest(api: AmwalAPIEndPoint.fetchHistoryPrices(period: period), decodeTo: HistoryPricesResponse.self)
    }
    
   
    
}
