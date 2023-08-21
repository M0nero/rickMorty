//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    private var window: UIWindow
    
    init(with window: UIWindow) {
        self.window = window
        super.init(with: BaseNavigationController(), onFinish: {})
    }
    
    override func start() {
        let mainCoordinator = MainCoordinator(with: navigationController, onFinish: restoreActivity())
        mainCoordinator.start()
        mainCoordinator.navigationController.navigationBar.prefersLargeTitles = true
        add(childCoordinator: mainCoordinator)
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
    }
    
    override func restoreActivity() -> Closure {
        { [weak self] in
            self?.navigationController = BaseNavigationController()
            self?.removeAll()
            self?.start()
        }
    }
}
