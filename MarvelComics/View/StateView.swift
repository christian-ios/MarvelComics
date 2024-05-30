//
//  StateView.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import SwiftUI

struct StateView: View {
    @ObservedObject var viewModel: ComicsListViewModel
    var body: some View {
        let message = viewModel.isLoading ? String(localized:"Loading...") : (viewModel.errorMessage ?? String(localized:"No comics found."))
        VStack {
            Text(message)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.emptyStateBackground))
    }
}
