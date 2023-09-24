//
//  DetailViewModel.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 23.09.2023.
//

import Foundation

class DetailViewModel {
    
    var character: CharacterModel
    
    var id: Int
    var imageCharacter: String
    var nameCharacter: String
    var statusCharacter: String
    var genderCharacter: String
    var speciesCharacter: String
    
    init(character: CharacterModel) {
        self.character = character
        
        self.id = character.id
        self.imageCharacter = character.image
        self.nameCharacter = character.name
        self.statusCharacter = character.status
        self.genderCharacter = character.gender
        self.speciesCharacter = character.species
    }
    
    var favDatabase = FavoriteDatabase()
    
    func setFav() {
        var items = favDatabase.get()
        if items.contains(id) {
            items.remove(id)
        } else {
            items.insert(id)
        }
        favDatabase.save(items: items)
    }

}
