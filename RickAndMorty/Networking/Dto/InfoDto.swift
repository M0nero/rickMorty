//
//  InfoDto.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

struct InfoDto: Decodable {
    var count: Int?
    var pages: Int?
    
    func toModel() -> Info? {
        guard let count = count,
              let pages = pages else { return nil }
        
        let model = Info(count: count, pages: pages)
        return model
    }
}
