//
//  NetworkClient.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Combine
import Foundation

final class NetworkClient: Client {
    private let transport: Transport
    private let jsonDecoder = JSONDecoder()
    private var cancellables = Set<AnyCancellable>()
    
    init(transport: Transport) {
        self.transport = transport
    }
    
    func performRequest<T: Decodable>(
        api: APIEndpoint,
        decodeTo: T.Type
    ) -> AnyPublisher<T, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                promise(.failure(.otherError(message: "Self is nil")))
                return
            }
            self.transport.send(endPoint: api)
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            promise(.failure(self.mapTransportError(error)))
                        case .finished:
                            break
                        }
                    },
                    receiveValue: { data, response in
                        let handledResponse = self.handle(data: data, response: response)
                        switch handledResponse {
                        case .success(let data):
                            do {
                                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                                promise(.success(decodedObject))
                            } catch {
                                promise(.failure(.otherError(message: "Decoding error: \(error.localizedDescription)")))
                            }
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }
                )
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
    }

    
    func performRequest(api: APIEndpoint) -> AnyPublisher<Data, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                promise(.failure(.otherError(message: "Self is nil")))
                return
            }
            
            self.transport.send(endPoint: api)
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            promise(.failure(self.mapTransportError(error)))
                        case .finished:
                            break
                        }
                    },
                    receiveValue: { data, response in
                        promise(self.handle(data: data, response: response))
                    }
                )
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
    }

    
    // Handle HTTP Response
    private func handle(data: Data, response: HTTPURLResponse) -> Result<Data, APIError> {
        switch response.statusCode {
        case 200...299:
            return .success(data)
        case 401:
            return .failure(.notAuthorized)
        case 403:
            return .failure(.forbiddenError)
        case 404:
            return .failure(.notFoundError)
        case 400...499:
            return decodeError(error: BackendErrors.self, from: data, response: response)
        case 504:
            return .failure(.requestTimeOut)
        case 500...:
            return decodeError(error: BackendError.self, from: data, response: response)
        default:
            return dumpError(data: data, response: response)
        }
    }
    
    // Decode data to the desired model
    private func decode<T: Decodable>(_ data: Data, to: T.Type) -> Result<T, APIError> {
        do {
            jsonDecoder.keyDecodingStrategy = .useDefaultKeys
            return .success(try jsonDecoder.decode(T.self, from: data))
        } catch {
            print("Decode Error: \(error)")
            return .failure(.otherError(message: error.localizedDescription))
        }
    }
    
    // Decode backend error
    private func decodeError<Err: Decodable>(
        error: Err.Type,
        from data: Data,
        response: HTTPURLResponse
    ) -> Result<Data, APIError> {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        if let backendError = try? jsonDecoder.decode(BackendErrors.self, from: data) {
            return .failure(.backendError(backendError))
        } else {
            return .failure(.otherError(message: "General error"))
        }
    }
    
    private func dumpError(data: Data, response: HTTPURLResponse) -> Result<Data, APIError> {
        let dataContent = String(data: data, encoding: .utf8) ?? "Invalid Data"
        return .failure(.otherError(message: "Status Code: \(response.statusCode), Data: \(dataContent)"))
    }
    
    private func mapTransportError(_ error: Error) -> APIError {
        if (error as NSError).code == NSURLErrorNotConnectedToInternet {
            return .noInternet
        } else if (error as NSError).code == NSURLErrorTimedOut {
            return .requestTimeOut
        } else {
            return .otherError(message: error.localizedDescription)
        }
    }
}

extension String {
    func addQueryParameters(queries: [URLQueryItem]) -> [String: Any] {
        var components = URLComponents()
        components.queryItems = queries
        return components.queryItems?.reduce(into: [String: Any]()) { result, item in
            result[item.name] = item.value
        } ?? [:]
    }
}

