//
//  CharactersListTypes.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

enum MainSection: Hashable {
    case general
}

struct ResultItem {
    let id: Int
    let title: String
    let imageUrl: String
}

extension ResultItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
