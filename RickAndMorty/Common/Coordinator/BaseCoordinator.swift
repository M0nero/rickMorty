//
//  BaseCoordinator.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import UIKit

class BaseCoordinator: NSObject, Coordinator {
    var onFinish: Closure
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var initialViewController: UIViewController?
    
    init(with navigationController: UINavigationController, onFinish: @escaping Closure) {
        self.navigationController = navigationController
        self.onFinish = onFinish
        super.init()
        navigationController.delegate = self
    }
    
    func start() {}
    
    func restoreActivity() -> Closure {
        return {}
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.present(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        navigationController.setViewControllers(viewControllers, animated: animated)
    }
    
    func add(childCoordinator: Coordinator) {
        if childCoordinators.firstIndex(where: {  $0 === childCoordinator }) == nil {
            childCoordinators.append(childCoordinator)
        }
    }
    
    func remove(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
    
    func removeAll() {
        childCoordinators = []
    }
    
    func didPop(_ viewController: UIViewController) {
        if viewController == initialViewController {
            onFinish()
        }
    }
}

extension BaseCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(viewController) else {
            return
        }
        didPop(viewController)
    }
}
