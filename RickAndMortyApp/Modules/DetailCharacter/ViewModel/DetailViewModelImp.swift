//
//  DetailViewModel.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 23.09.2023.
//

import Foundation

protocol DetailViewModel {
    var character: CharacterModel { get set}
    var favDatabase: FavoriteDatabase { get set}
}

class DetailViewModelImp: DetailViewModel {
    
    var character: CharacterModel
    var favDatabase = FavoriteDatabase()
    
    var id: Int
    var imageCharacter: String
    var nameCharacter: String
    var statusCharacter: String
    var genderCharacter: String
    var speciesCharacter: String
    var isFavourite: Bool
    
    
    init(character: CharacterModel) {
        self.character = character
        
        self.id = character.id
        self.imageCharacter = character.image
        self.nameCharacter = character.name
        self.statusCharacter = character.status.rawValue
        self.genderCharacter = character.gender.rawValue
        self.speciesCharacter = character.species
        self.isFavourite = favDatabase.get().contains(id)
    }
    
    func setFav() -> Bool {
        var items = favDatabase.get()
        if items.contains(id) {
            items.remove(id)
        } else {
            items.insert(id)
        }
        favDatabase.save(items: items)
        
        return items.contains(id)
    }
}
