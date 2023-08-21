//
//  Gender.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

enum Gender: String {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    init(fromRawValue: String) {
        self = Gender(rawValue: fromRawValue) ?? .unknown
    }
}
