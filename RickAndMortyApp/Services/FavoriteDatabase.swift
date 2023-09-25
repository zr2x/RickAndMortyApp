//
//  FavoriteDatabase.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 24.09.2023.
//

import Foundation

class FavoriteDatabase {
    private let FAV_KEY = "fav_key"
    
    func save(items: Set<Int>) {
        let arr = Array(items)
        UserDefaults.standard.setValue(arr, forKey: FAV_KEY)
    }
    
    func get() -> Set<Int> {
        let arr = UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? []
        return Set(arr)
    }
}
