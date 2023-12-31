//
//  NetworkService.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 22.09.2023.
//

import Foundation

enum NetworkError: Error {
    case badUrl, badData, serverError
}

protocol NetworkServiceProtocol {
    associatedtype ResponseType: Decodable
    associatedtype ErrorType: Error
    static func getCharacter<ResponseApi: Decodable>(for type: ResponseApi.Type, completion: @escaping (Result<ResponseApi, ErrorType>)-> Void)
}

public class NetworkService: NetworkServiceProtocol {
    typealias ResponseType = AllCharactersModel
    typealias ErrorType = NetworkError
    
    static func getCharacter<ResponseApi: Decodable>(for type: ResponseApi.Type, completion: @escaping (Result<ResponseApi, NetworkError>) -> Void) {
        let urlString = URL(string: NetworkConstant.shared.serverAddress + NetworkConstant.shared.apiKey + NetworkConstant.shared.character)
        guard let url = urlString else {
            completion(.failure(NetworkError.badUrl))
            return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { dataResponse, _, error in
            if let data = dataResponse, error == nil, let result = try? JSONDecoder().decode(ResponseApi.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(NetworkError.badData))
            }
        }
        task.resume()
    }
}
