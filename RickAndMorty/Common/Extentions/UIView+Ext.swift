//
//  UIView+Ext.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
