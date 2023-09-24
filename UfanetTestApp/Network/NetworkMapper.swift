//
//  NetworkMapper.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 24.09.2023.
//

import Foundation

class NetworkMapper {
    
    func characterResponse(data: Data) -> [AllCharactersModel] {
        let allCharacters = try? JSONDecoder().decode([AllCharactersModel].self, from: data)
        return allCharacters ?? []
    }
}
