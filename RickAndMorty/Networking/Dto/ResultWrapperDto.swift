//
//  CharactersWrapperDto.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

struct ResultWrapperDto: Decodable {
    var info: InfoDto?
    var results: [ResultDto]?
    
    func toModel() -> AnyPublisher<ResultWrapper, Error> {
        Deferred {
            Future { promise in
                guard let info = info?.toModel(),
                    let results = results?.compactMap({ $0.toModel() }) else {
                    promise(.failure(ParseError.convertDtoError))
                    return
                }
                let model = ResultWrapper(info: info, results: results)
                promise(.success(model))
            }
        }
        .eraseToAnyPublisher()
    }
}
