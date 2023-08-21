//
//  ColorConstants.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import UIKit

struct ColorConstants {
    var background = wrapper(UIColor(named: "background"))
    var darkGunmetal = wrapper(UIColor(named: "darkGunmetal"))
    var gunmetal = wrapper(UIColor(named: "gunmetal"))
    var harlequinGreen = wrapper(UIColor(named: "harlequinGreen"))
    var lavenderGray = wrapper(UIColor(named: "lavenderGray"))
    var spanishGray = wrapper(UIColor(named: "spanishGray"))
    
    private static func wrapper(_ value: UIColor?) -> UIColor {
        guard let value = value else {
            fatalError("ColorConstants handle nil value")
        }
        return value
    }
}
