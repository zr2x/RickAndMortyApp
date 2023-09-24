//
//  CharacterCellViewModel.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 22.09.2023.
//

import Foundation

final class CharacterCellViewModel {

    var id: Int
    var image: String
    var name: String
    var status: String
    var gender: String
    var species: String
    
    init(character: CharacterModel) {
        self.id = character.id
        self.image = character.image
        self.name = character.name
        self.status = character.status
        self.gender = character.gender
        self.species = character.species
    }
}
