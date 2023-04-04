//
//  APIManager.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//


import Combine
import Foundation

enum APIError: Error {
    case noResponse
}

class APIManager: APIServicable {

    let jsonDecoder = JSONDecoder()

    func getTrendingRecipes() -> AnyPublisher<[RecipeModel], Error> {
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        return Future<[RecipeModel], Error> { [weak self] promise in
            guard let self,
                let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
                promise(.failure(APIError.noResponse))
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try self.jsonDecoder.decode(RecipesResponseModel.self, from: data)
                promise(.success(jsonData.recipes))
            } catch {
                promise(.failure(error))
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .eraseToAnyPublisher()
    }
}

protocol APIServicable {
    func getTrendingRecipes() -> AnyPublisher<[RecipeModel], Error>
}

