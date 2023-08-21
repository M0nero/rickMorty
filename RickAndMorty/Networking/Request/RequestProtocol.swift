//
//  RequestProtocol.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

protocol RequestProtocol {
    func send<TData: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<TData, Error>
    func send<TData: Decodable, UData: Encodable>(_ endpoint: Endpoint, payload: UData) -> AnyPublisher<TData, Error>
}
