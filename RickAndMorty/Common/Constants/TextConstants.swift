//
//  TextConstants.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import UIKit

protocol TextConstants {}

// swiftlint: disable identifier_name
extension TextConstants {
    
}

struct TextConstantsWrapper<Base>: TextConstants {
    private let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

protocol TextConstantsInterface: AnyObject {}

extension TextConstantsInterface {
    var text: TextConstantsWrapper<Self> { TextConstantsWrapper(self) }
}

extension UIView: TextConstantsInterface {}
extension UIViewController: TextConstantsInterface {}
extension ViewModel: TextConstantsInterface {}
