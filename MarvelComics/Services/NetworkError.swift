//
//  NetworkError.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case networkConnectionError
    case unknown
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return String(localized: "Invalid URL for comic data.")
        case .noData, .decodingError:
            return String(localized: "No data available.")
        case .serverError(let statusCode):
            return String(localized: "Server error with status code \(statusCode).")
        case .networkConnectionError:
            return String(localized: "Network connection error.")
        case .unknown:
            return String(localized: "Unknown error occurred.")
        }
    }
}

