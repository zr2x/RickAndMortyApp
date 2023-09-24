//
//  MainViewModel.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 22.09.2023.
//

import Foundation

protocol MainViewModel {
    
    var dataSource: AllCharactersModel? { get set }
    var onLoadCharacters: (([CharacterModel]) -> ())? { get set }
    var onErrorHandler: ((Error) -> ())? { get set }
    
    func getData()
    func getFavouriteList() -> Set<Int>
    func setFavourite(id: Int)
}

class MainViewModelImp: MainViewModel {
    
    var onLoadCharacters: (([CharacterModel]) -> ())?
    var onErrorHandler: ((Error) -> ())?
    
    var dataSource: AllCharactersModel?
    
    var favouriteDataBase = FavoriteDatabase()
    
    func getData() {
        NetworkService.getCharacter { [weak self] result in
            switch result {
            case .success(let data):
                self?.onLoadCharacters?(data.results)
            case .failure(let error):
                self?.onErrorHandler?(error)
                // TODO: Error handler
            }
        }
    }


    func getFavouriteList() -> Set<Int> {
        favouriteDataBase.get()
    }
    
    func setFavourite(id: Int) {
        var items = favouriteDataBase.get()
        if items.contains(id) {
            items.remove(id)
        } else {
            items.insert(id)
        }
        favouriteDataBase.save(items: items)
    }
}
