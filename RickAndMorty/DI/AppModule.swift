//
//  AppModule.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct AppModule {
    func registerDependencies(in container: Container) {
        container.autoregister(CharactersListViewModel.self, initializer: CharactersListViewModel.init)
    }
}
