//
//  Parser.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

protocol Parser {
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error>
    func encode<T: Encodable>(_ data: T) -> Data?
}
