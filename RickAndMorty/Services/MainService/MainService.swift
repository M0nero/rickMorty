//
//  MainService.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import Foundation
import Combine

final class MainService: MainServiceProtocol {
    let controller: MainApiController
    
    init(_ controller: MainApiController) {
        self.controller = controller
    }
    
    func getList(page: Int) -> AnyPublisher<ResultWrapper, Error> {
        return controller.getList(page: page)
            .flatMap({ $0.toModel() })
            .eraseToAnyPublisher()
    }
}
