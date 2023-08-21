//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var scheme: String { get }
    var httpMethod: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var params: [String: String] { get }
    var headers: HTTPHeaders { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return AppConfig.shared.baseUrl
    }
    
    var headers: HTTPHeaders {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
 }
