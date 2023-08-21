//
//  MainApiController.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

final class MainApiController {
    private let api: RequestProtocol
    
    init(_ api: RequestProtocol) {
        self.api = api
    }
    
    func getList(page: Int) -> AnyPublisher<ResultWrapperDto, Error> {
        let endpoint = MainEndpoint.getCharacters(page: page)
        return api.send(endpoint)
    }
}
