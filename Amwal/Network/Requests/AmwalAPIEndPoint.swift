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
    //    case movieSearch(query: String)
    //    case movieDtail(movie_id: Int)
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
            //            let s = ""
            //            return  "/v0/prices/history/\(s)period_id\(period)"
            
            
            //        case .movieSearch:
            //            return "search/movie"
            //        case .movieDtail(let movie_id):
            //            return "/movie/\(movie_id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchHistoryPrices/*.movieSearch,.movieDtail*/:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchHistoryPrices(let period):
            
            let urlParameters: [String: Any] = [
//                "ticker": "ix-tasi",
                "period_id": period
            ]
            return .requestParameters(parameters: urlParameters, encoding: .queryString)
            
            //        case .movieSearch(let query):
            //            let urlParameters: [String: Any] = [
            //                "query": query
            //            ]
            //            return .requestParameters(parameters: urlParameters, encoding: .queryString)
            //
            //        case .movieDtail(let movieId):
            //            return .requestPlain
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .fetchHistoryPrices/*,.movieSearch,.movieDtail*/:
            return HeadersRequest.shared.getHeaders(type: .normal)
        }
    }
}
