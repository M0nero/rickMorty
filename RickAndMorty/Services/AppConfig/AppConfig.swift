//
//  AppConfig.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

final class AppConfig {
    static let shared = AppConfig()
    
    private enum Key: String {
        case baseUrl = "APPLICATION_BASE_URL"
    }
    
    private func getValue(key: Key) -> String {
        guard let value = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            fatalError("AppConfig not found value")
        }
        return value
    }
    
    lazy var baseUrl: String = getValue(key: .baseUrl)
}
