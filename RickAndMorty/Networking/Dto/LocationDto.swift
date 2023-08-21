//
//  LocationDto.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

struct LocationDto: Decodable {
    var name: String?
    var url: String?
    
    func toModel() -> Location? {
        guard let name = name,
              let url = url else { return nil }
        
        let model = Location(name: name, url: url)
        return model
    }
}
