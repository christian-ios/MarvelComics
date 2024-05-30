//
//  ComicsListViewModel.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import Foundation

final class ComicsListViewModel: ObservableObject {
    @Published var comics: [Comic] = []
    @Published var filteredComics: [Comic] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    var searchText: String = "" {
        didSet {
            filterComics()
        }
    }
    
    private var comicsService: ComicsServiceProtocol
    
    init(comicsService: ComicsServiceProtocol = ComicsService()) {
        self.comicsService = comicsService
    }
    
    private func filterComics() {
        if searchText.isEmpty {
            filteredComics = comics
        } else {
            let lowercaseSearchText = searchText.lowercased()
            filteredComics = comics.filter { comic in
                let titleMatches = comic.title.lowercased().contains(lowercaseSearchText)
                return titleMatches
            }
        }
    }
    
    @MainActor
    func loadComics() async {
        isLoading = true
        errorMessage = nil
        do {
            let fetchedComics = try await comicsService.fetchComics()
            self.comics = fetchedComics
            self.filterComics()
        }
        catch let error as NetworkError {
            self.errorMessage = error.errorMessage
        } catch {
            self.errorMessage = String(localized: "An unexpected error occurred: \(error.localizedDescription)")
        }
        self.isLoading = false
        
    }
}
