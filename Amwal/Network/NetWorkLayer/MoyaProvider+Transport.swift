//
//  moyaProvider+Extension.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Moya
import Combine
import Foundation

extension MoyaProvider: Transport where Target == MoyaAPI {
    func send(endPoint: APIEndpoint) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        Future { promise in
            let moyaTask: Moya.Task
            switch endPoint.task {
            case .requestJSONEncodable(let encodable):
                moyaTask = .requestJSONEncodable(encodable)
            case .requestPlain:
                moyaTask = .requestPlain
            case .requestData(let data):
                moyaTask = .requestData(data)
            case .requestParameters(parameters: let params, encoding: let encoding):
                moyaTask = .requestParameters(parameters: params, encoding: encoding)
            case .uploadMultipart(let multipart):
                moyaTask = .uploadMultipart(multipart)
            case .uploadCompositeMultipart(let multipart, let urlParameters):
                moyaTask = .uploadCompositeMultipart(multipart, urlParameters: urlParameters)
            case .requestCompositeData(let bodyData, let urlParameters):
                moyaTask = .requestCompositeData(bodyData: bodyData, urlParameters: urlParameters)
            }

            let api = MoyaAPI(
                baseURL: endPoint.baseURL,
                path: endPoint.path,
                method: Moya.Method(rawValue: endPoint.method.rawValue),
                sampleData: Data(),
                task: moyaTask,
                headers: endPoint.headers
            )
            
            self.request(api) { moyaResult in
                switch moyaResult {
                case .success(let moyaResponse):
                    if let response = moyaResponse.response {
                        print(response)
                        promise(.success((data: moyaResponse.data, response: response)))
                    } else {
                        promise(.failure(APIError.invalidResponse))
                    }
                case .failure(let moyaError):
                    promise(.failure(moyaError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

struct MoyaAPI: TargetType {
    let baseURL: URL
    let path: String
    let method: Moya.Method
    let sampleData: Data
    let task: Moya.Task
    let headers: [String: String]?
}
