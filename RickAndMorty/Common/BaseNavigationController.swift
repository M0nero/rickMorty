//
//  BaseNavigationController.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = background
            navigationBarAppearance.shadowColor = .clear
            navigationBarAppearance.largeTitleTextAttributes =
            [NSAttributedString.Key.font: largeTitleFont]
            navigationBarAppearance.titleTextAttributes =
            [NSAttributedString.Key.font: titleFont]
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}

// MARK: - Resources
private extension BaseNavigationController {
    var background: UIColor { appearance.colors.background }
    
    var largeTitleFont: UIFont { .systemFont(ofSize: 28) }
    var titleFont: UIFont { .systemFont(ofSize: 17) }
}
