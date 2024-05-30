//
//  ComicDetailsViewModel.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

final class ComicDetailsViewModel: ObservableObject {
    @Published var comics: [Comic] = []
    @Published var viewing: Comic
    @Published var viewingIndex: Int
    
    var hasPrevious: Bool {
        viewingIndex > 0
    }
    
    var hasNext: Bool {
        viewingIndex < comics.count - 1
    }
    
    init(comics: [Comic], viewing: Comic) {
           self.comics = comics
           self.viewing = viewing
           self.viewingIndex = comics.firstIndex { $0.id == viewing.id } ?? 0
    }
    
    func viewNext() {
        guard hasNext else { return }
        viewingIndex += 1
        viewing = comics[viewingIndex]
    }
    
    func viewPrevious() {
        guard hasPrevious else { return }
        viewingIndex -= 1
        viewing = comics[viewingIndex]
    }
}
    
