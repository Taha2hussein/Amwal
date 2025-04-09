//
//  MovieAPIEndPoint.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Foundation
import Moya
enum AmwalAPIEndPoint {
    case fetchHistoryPrices(period: String)
    case fetchAnnouncment(page: Int)
    case topMoveries(period: String)
    case fetchSecuritesFilter(ticket: String,marketID: Int, sectorID: Int)
}

extension AmwalAPIEndPoint: APIEndpoint {
    var baseURL: URL {
        return URL(string: EnviromentConfigurations.baseUrl.rawValue)!
    }
    
    var path: String {
        switch self {
        case .fetchHistoryPrices:
            //            let type = UserDefaultModel.shared.getamwalType()
            let type = "ix-tasi"
            return  "/v0/prices/history/\(type)"
        case .fetchAnnouncment:
            return "/v0/announcements"
        case .topMoveries:
            return "/v0/prices/top-movers"
        case .fetchSecuritesFilter:
       return "/v0/securities-filter"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchHistoryPrices,.fetchAnnouncment,.topMoveries,.fetchSecuritesFilter:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchHistoryPrices(let period):
            
            let urlParameters: [String: Any] = [
                //  "ticker": "ix-tasi",
                "period_id": period
            ]
            return .requestParameters(parameters: urlParameters, encoding: .queryString)
            
        case .fetchAnnouncment(let page):
            let urlParameters: [String: Any] = [
                "limit": page,
                "skip":0,
                "language": "ar"
            ]
            return .requestParameters(parameters: urlParameters, encoding: .queryString)
            
        case .topMoveries(let period):
            let urlParameters: [String: Any] = [
                "period_id": period,
                "market_id":1,
                "limit":10,
                "type_id":1
            ]
            return .requestParameters(parameters: urlParameters, encoding: .queryString)
            
        case .fetchSecuritesFilter(let ticket,let marketID,let sectorID):
            let urlParameters: [String: Any] = [
                "ticker_or_name": ticket,
                "type_id":1,
                "sector_id":sectorID,
                "market_id":marketID
            ]
            return .requestParameters(parameters: urlParameters, encoding: .queryString)
            
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .fetchHistoryPrices,.fetchAnnouncment,.topMoveries,.fetchSecuritesFilter:
            return HeadersRequest.shared.getHeaders(type: .normal)
        }
    }
}
