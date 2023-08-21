//
//  AppearanceConstants.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import UIKit

protocol AppearanceConstants {}

extension AppearanceConstants {
    var colors: ColorConstants { ColorConstants() }
    var images: ImageConstants { ImageConstants() }
    var fonts: FontConstants { FontConstants() }
}

struct AppearanceConstantsWrapper<Base>: AppearanceConstants {
    private let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

protocol AppearanceConstantsInterface: AnyObject {}

extension AppearanceConstantsInterface {
    var appearance: AppearanceConstantsWrapper<Self> { AppearanceConstantsWrapper(self) }
}

extension UIView: AppearanceConstantsInterface {}
extension UIViewController: AppearanceConstantsInterface {}
