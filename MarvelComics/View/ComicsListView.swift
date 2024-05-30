//
//  ComicsListView.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import SwiftUI

struct ComicsListView: View {
    @StateObject var viewModel = ComicsListViewModel()
    @State private var searchText = ""
    @State private var selectedComic: Comic?
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.filteredComics) { comic in
                    Button(action: {
                        selectedComic = comic
                    }) {
                        ComicRowView(comic: comic, viewModel: viewModel)
                            .accessibilityIdentifier("comicRow-\(comic.id)")
                    }
                }
                .accessibilityIdentifier("comicsList")
                .refreshable {
                    await viewModel.loadComics()
                }
                
                if viewModel.isLoading || viewModel.filteredComics.isEmpty {
                    VStack {
                        Spacer()
                        StateView(viewModel: viewModel)
                            .frame(maxWidth: .infinity)
                            .opacity(0.8)
                            .cornerRadius(10)
                            .accessibilityIdentifier("stateView")
                        
                        Spacer()
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search by title")
            .navigationTitle(String(localized: "Marvel Comics"))
            .fullScreenCover(item: $selectedComic) { comic in
                ComicDetailsView(viewModel: .init(comics: viewModel.filteredComics, viewing: comic))
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .task {
            await viewModel.loadComics()
        }
    }
}

struct ComicsListView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsListView()
    }
}

