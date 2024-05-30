//
//  ComicsService.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

protocol ComicsServiceProtocol {
    func fetchComics() async throws -> [Comic]
}

final class ComicsService: ComicsServiceProtocol {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchComics() async throws -> [Comic] {
        let url = Constants.API.comicsListUrl()
        do {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.addAuthorization(publicKey: Constants.API.apiKey, privateKey: Constants.API.privateKey)
            urlComponents?.queryItems?.append(URLQueryItem(name: "limit", value: "30"))

            guard let finalURL = urlComponents?.url else {
                throw NetworkError.invalidURL
            }
            let comicsResponse: ComicsResponse = try await networkManager.fetchData(from: finalURL)
            guard !comicsResponse.data.results.isEmpty  else {
                throw NetworkError.noData
            }
            return comicsResponse.data.results
        } catch {
            throw error
        }
    }
}
