//
//  Request.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

final class Request: RequestProtocol {
    private let sessionManager: URLSession
    private let parser: Parser
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        sessionManager = URLSession(configuration: configuration)
        parser = DecodeParser()
    }
    
    func send<TData: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<TData, Error> {
        return convertToUrl(from: endpoint)
            .flatMap { self.request($0) }
            .flatMap { self.parser.decode($0) }
            .eraseToAnyPublisher()
    }
    
    func send<TData: Decodable, UData: Encodable>(_ endpoint: Endpoint, payload: UData) -> AnyPublisher<TData, Error> {
        return convertToUrl(from: endpoint, payload: payload)
            .flatMap { self.request($0) }
            .flatMap { self.parser.decode($0) }
            .eraseToAnyPublisher()
    }
    
    private func request(_ url: URLRequest, withoutResponse: Bool = false) -> AnyPublisher<Data, Error> {
        Deferred {
            Future { promise in
                Log.log(for: url)
                
                let startTime = Date()
                
                let task = self.sessionManager.dataTask(with: url) { data, response, error in
                    
                    Log.log(response: response as? HTTPURLResponse,
                            data: data,
                            error: error,
                            startRequestTime: startTime,
                            endRequestTime: Date())
                    
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        promise(.failure(ApiError.emptyResponseError))
                        return
                    }
                    
                    let statusCode = httpResponse.statusCode
                    
                    guard (200...299).contains(statusCode) else {
                        if let responseData = data,
                           let stringResponse = String(data: responseData, encoding: .utf8) {
                            promise(.failure(ApiError.notSuccessfulHttpCode(code: statusCode, response: stringResponse)))
                        } else {
                            promise(.failure(ApiError.notSuccessfulHttpCode(code: statusCode, response: "")))
                        }
                        return
                    }
                    
                    if withoutResponse {
                        promise(.success(Data()))
                    } else {
                        if let responseData = data {
                            promise(.success(responseData))
                        } else {
                            promise(.failure(ApiError.emptyResponseError))
                        }
                    }
                }
                
                task.resume()
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func convertToUrl<T: Encodable>(from endpoint: Endpoint, payload: T?) -> AnyPublisher<URLRequest, Error> {
        Deferred {
            Future { promise in
                var components = URLComponents()
                components.scheme = endpoint.scheme
                components.host = endpoint.host
                components.path = endpoint.path
                print(endpoint.scheme, endpoint.host, endpoint.path)
                let filteredParams = endpoint.params.filter { $0.value != "" }
                components.queryItems = filteredParams.compactMap { (key, value) in
                    guard let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                        return nil
                    }
                    return URLQueryItem(name: key, value: encodedValue)
                }
                guard let url = components.url else {
                    promise(.failure(ApiError.convertUrlError))
                    return
                }
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = endpoint.httpMethod.rawValue
                urlRequest.allHTTPHeaderFields = endpoint.headers
                if let payload = payload {
                    urlRequest.httpBody = self.parser.encode(payload)
                }
                
                promise(.success(urlRequest))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func convertToUrl(from endpoint: Endpoint) -> AnyPublisher<URLRequest, Error> {
        convertToUrl(from: endpoint, payload: nil as AnyNil?)
    }
}
