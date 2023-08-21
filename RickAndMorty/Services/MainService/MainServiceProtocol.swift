//
//  MainServiceProtocol.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import Foundation
import Combine

protocol MainServiceProtocol {
    func getList(page: Int) -> AnyPublisher<ResultWrapper, Error>
}
