//
//  ImageConstants.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import UIKit

struct ImageConstants {
    
    private static func wrapper(_ value: UIImage?) -> UIImage {
        guard let value = value else {
            fatalError("ImageConstants handle nil value")
        }
        return value
    }
}
