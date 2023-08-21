//
//  ResultDto.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

struct ResultDto: Decodable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: LocationDto?
    var location: LocationDto?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
    
    func toModel() -> Result? {
        guard let id = id,
              let name = name,
              let species = species,
              let type = type,
              let origin = origin?.toModel(),
              let location = location?.toModel(),
              let image = image,
              let episode = episode,
              let url = url,
              let created = created else { return nil }
        let gender = Gender(fromRawValue: gender ?? "")
        let status = Status(fromRawValue: status ?? "")
        let model = Result(id: id,
                           name: name,
                           status: status,
                           species: species,
                           type: type,
                           gender: gender,
                           origin: origin,
                           location: location,
                           image: image,
                           episode: episode,
                           url: url,
                           created: created)
        return model
    }
}
