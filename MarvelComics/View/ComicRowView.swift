//
//  ComicRowView.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import SwiftUI

struct ComicRowView: View {
    let comic: Comic
    @ObservedObject var viewModel: ComicsListViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: comic.thumbnail?.imagePath.secureUrl() ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                default:
                    Image(systemName: "photo")
                        .resizable()
                }
            }.aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 100)
                .clipped()
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(comic.title)
                    .font(.headline)
            }
        }
        .padding(.vertical, 4)
    }
}
