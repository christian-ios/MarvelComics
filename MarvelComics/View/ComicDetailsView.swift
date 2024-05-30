//
//  ComicDetailsView.swift
//  MarvelComics
//
//  Created by Christian Curiel on 5/28/24.
//

import SwiftUI

struct ComicDetailsView: View {
    @StateObject var viewModel: ComicDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let comic = viewModel.viewing
        let description = comic.firstText.removeHtmlEntities()
        
        ZStack(alignment: .topTrailing) {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Color(.clear)
                            .padding(10)
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
                            }
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 225)
                            .clipped()
                            .foregroundColor(.gray)
                            
                            VStack {
                                Button(action: {}) {
                                    Text("READ NOW")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(10)
                                        .font(.system(size: 14, weight: .bold))
                                        .background(Color.purple)
                                        .cornerRadius(8)
                                }
                                
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "checkmark.circle")
                                        Text("MARK AS READ")
                                            .font(.system(size: 14, weight: .bold))
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color.black)
                                    .cornerRadius(8)
                                }
                                
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "plus.circle")
                                        Text("ADD TO LIBRARY")
                                            .font(.system(size: 14, weight: .bold))
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color.black)
                                    .cornerRadius(8)
                                }
                                
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "arrow.down.circle")
                                        Text("READ OFFLINE")
                                            .font(.system(size: 14, weight: .bold))
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color.black)
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                        
                        Text(comic.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        Divider()
                            .background(Color.white)
                        
                        
                        
                        Text(description.isEmpty ? String(localized:"No Description") : description)
                            .padding()
                            .foregroundColor(.gray)
                    }
                }
                
                HStack {
                    Button(action: {
                        viewModel.viewPrevious()
                    }) {
                        Text("PREVIOUS")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .opacity(viewModel.hasPrevious ? 1.0 : 0.5)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!viewModel.hasPrevious)
                    Spacer()
                    Button(action: {
                        viewModel.viewNext()
                    }) {
                        Text("NEXT")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .opacity(viewModel.hasNext ? 1.0 : 0.5)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!viewModel.hasNext)
                }
                .padding()
                .background(Color.black)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .foregroundColor(.white)
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
            }
            .padding([.top, .trailing], 20)
        }
        .accessibilityIdentifier("comicDetailView")
    }
    
    
}
#Preview {
    ComicDetailsView(viewModel: .init(comics: [.previewComic,.previewComic,.previewComic], viewing: .previewComic))
}
