//
//  String+Extensions.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

extension String {
    func removeHtmlEntities() -> String {
            return self.replacingOccurrences(of: "<br>", with: "\n")
                       .replacingOccurrences(of: "<br/>", with: "\n")
                       .replacingOccurrences(of: "<br />", with: "\n")
    }
    
    func secureUrl() -> String {
        return self.replacingOccurrences(of: "http://", with: "https://")
    }
}
