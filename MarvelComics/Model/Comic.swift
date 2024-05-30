//
//  Comic.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

struct Comic: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let textObjects: [TextObjects]?
    let thumbnail: Thumbnail?
    var firstText: String {
        textObjects?.first?.text ?? ""
    }
}
struct TextObjects: Codable {
    let text: String
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
    var imagePath: String { path + "." + `extension`}
}

extension Comic {
    static var previewComic: Comic {
        return Comic(id: 1234, title: "Test Comic", description: "Test Description", textObjects: [.init(text: "Test")], thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/b0/4c7d666c0e58a", extension: "jpg"))
    }
}
