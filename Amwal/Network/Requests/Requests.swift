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
    
    func fetchAnnouncment(page: Int) -> AnyPublisher<[AnnouncmentResponseElement], APIError> {
        return self.client.performRequest(api: AmwalAPIEndPoint.fetchAnnouncment(page: page), decodeTo: [AnnouncmentResponseElement].self)
    }
    
    func fetchTopMoveries(period: String) -> AnyPublisher<TopMveriesResponse, APIError> {
        return self.client.performRequest(api: AmwalAPIEndPoint.topMoveries(period: period), decodeTo: TopMveriesResponse.self)
    }
    
    func fetchSecuritesFilter(ticket: String,marketID: Int, sectorID: Int) -> AnyPublisher<[SecuritesFilterResponseElement], APIError> {
        return self.client.performRequest(api: AmwalAPIEndPoint.fetchSecuritesFilter(ticket: ticket, marketID: marketID, sectorID: sectorID), decodeTo: [SecuritesFilterResponseElement].self)
    }
    
   
    
    
  
}
