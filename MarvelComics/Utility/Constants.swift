//
//  Constants.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

struct Constants {
    struct API {
        static var apiKey: String {
            return Bundle.main.object(forInfoDictionaryKey: "MarvelPublicKey") as? String ?? ""
        }
        
        static var privateKey: String {
            return Bundle.main.object(forInfoDictionaryKey: "MarvelPrivateKey") as? String ?? ""
        }
        
        static var baseURL: URL {
            return URL(string: Bundle.main.object(forInfoDictionaryKey: "MarvelBaseUrl") as? String ?? "")!
        }
        
        static func comicsListUrl() -> URL {
            return baseURL.appendingPathComponent("comics")
        }
        
    }
}
