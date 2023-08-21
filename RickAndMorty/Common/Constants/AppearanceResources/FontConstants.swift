//
//  FontConstants.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import UIKit

struct FontConstants {
    let verySmallMedium: UIFont = .systemFont(ofSize: 12, weight: .medium)
    let smallMedium: UIFont = .systemFont(ofSize: 14, weight: .medium)
    let normalMedium: UIFont = .systemFont(ofSize: 15, weight: .medium)
    
    private static func wrapper(_ value: UIFont?) -> UIFont {
        guard let value = value else {
            for family: String in UIFont.familyNames {
                print(family)
                for names: String in UIFont.fontNames(forFamilyName: family) {
                    print("== \(names)")
                }
            }
            fatalError("FontConstants handle nil value")
        }
        return value
    }
}
