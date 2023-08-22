//
//  MainCoordinator.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    override func start() {
        let viewController = CharactersListViewController()
        initialViewController = viewController
        viewController.onEvent = { [weak self] event in
            switch event {
            case .showCharacter(let character):
                self?.showCharacter(character)
            }
        }
        
        setViewControllers([viewController], animated: true)
    }
    
    // TODO: Make Character SwiftUI View
    private func showCharacter(_ character: Result) {
        print(character)
    }
}
