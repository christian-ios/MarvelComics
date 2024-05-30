//
//  MockNetworkManager.swift
//  MarvelComicsTests
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation
import XCTest
@testable import MarvelComics

class MockNetworkManager: NetworkManagerProtocol {
    
    // Used to simulate different error responses through these properties
    var returnEmpty = false
    var returnDecodingError = false
    func fetchData<T>(from url: URL) async throws -> T where T : Decodable {
        if returnEmpty {
            throw NetworkError.noData
        }
        if returnDecodingError {
            throw NetworkError.decodingError
        }
        let comic1 = Comic.previewComic
        let comic2 = Comic.previewComic
        let comicResponse = ComicsResponse(code: 200, status: "Ok", attributionText: "Test", data: .init(count: 2, results: [comic1, comic2]))
        return comicResponse as! T
    }
}
