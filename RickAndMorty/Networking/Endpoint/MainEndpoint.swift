//
//  MainEndpoint.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

enum MainEndpoint {
    case getCharacters(page: Int)
}

extension MainEndpoint: Endpoint {
    var httpMethod: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCharacters: return "/api/character"
        }
    }
    
    var params: [String: String] {
        switch self {
        case .getCharacters(let page):
            return ["page": String(page)]
        }
    }
}
