//
//  NetworkManager.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            //Handles decoding strategy for snake case -> camel case
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                if let decodingError = error as? DecodingError {
                                   printDecodingError(decodingError)
                               }
                throw NetworkError.decodingError
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkConnectionError
        }
    }
    private func printDecodingError(_ error: DecodingError) {
            switch error {
            case .typeMismatch(let type, let context):
                print("Type mismatch error for type \(type): \(context.debugDescription)")
            case .valueNotFound(let type, let context):
                print("Value not found error for type \(type): \(context.debugDescription)")
            case .keyNotFound(let key, let context):
                print("Key not found error for key \(key): \(context.debugDescription)")
            case .dataCorrupted(let context):
                print("Data corrupted error: \(context.debugDescription)")
            @unknown default:
                print("Unknown decoding error: \(error.localizedDescription)")
            }
        }

}
