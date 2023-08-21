//
//  NetworkModule.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct NetworkModule {
    func registerDependencies(in container: Container) {
        container.autoregister(RequestProtocol.self, initializer: Request.init)
        container.autoregister(Parser.self, initializer: DecodeParser.init)
        container.autoregister(MainApiController.self, initializer: MainApiController.init)
    }
}
