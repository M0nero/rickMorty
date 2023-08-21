//
//  ParseError.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

enum ParseError: Error {
    case noValidJSON
    case convertDtoError
}

extension ParseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .convertDtoError:
            return "convertDtoError"
        case .noValidJSON:
            return "noValidJSON"
        }
    }
}
