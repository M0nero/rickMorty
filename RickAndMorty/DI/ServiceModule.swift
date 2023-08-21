//
//  ServiceModule.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct ServiceModule {
    func registerDependencies(in container: Container) {
        container.autoregister(MainServiceProtocol.self, initializer: MainService.init)
    }
}
