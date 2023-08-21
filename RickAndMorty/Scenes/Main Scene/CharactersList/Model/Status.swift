//
//  Status.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

enum Status: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    init(fromRawValue: String) {
        self = Status(rawValue: fromRawValue) ?? .unknown
    }
}
