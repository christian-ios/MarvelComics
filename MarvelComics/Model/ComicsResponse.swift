//
//  ComicsResponse.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

struct ComicsResponse: Codable {
    let code: Int
    let status: String
    let attributionText: String
    let data: ComicsResponseData
}

struct ComicsResponseData: Codable {
    let count: Int
    let results: [Comic]
}
