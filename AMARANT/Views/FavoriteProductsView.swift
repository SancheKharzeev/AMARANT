//
//  FavoriteProductsView.swift
//  AMARANT
//
//  Created by Александр Х on 10.09.2024.
//

import SwiftUI

struct FavoriteProductsView: View {
    @ObservedObject var favouriteManager: FavouriteManager
    @State private var favoriteProducts: [Product] = []
    @ObservedObject var serverDataModel: ServerDataModel

    var body: some View {
        VStack {
            if favoriteProducts.isEmpty {
                Text("Нет товаров в избранном")
                    .font(.title)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(favoriteProducts) { product in
                        VStack {
                            // Картинка продукта
                            if URL(string: product.imageUrl) != nil {
                                AsyncImage(url: URL(string: product.imageUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 170, height: 170)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 170, height: 170)
                                            .cornerRadius(10)
                                    case .failure:
                                        Image(product.imageUrl)
                                            .resizable()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .frame(width: 170, height: 170)
                                            .scaledToFit()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            } else {
                                Color.red
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            }
                            HStack {
                                // Название продукта и цена
                                Text(product.name)
                                    .font(.headline)
                                Spacer()
                                Text("\(product.price) руб.")
                                    .font(.subheadline)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                removeFromFavorites(product: product)
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            loadFavoriteProducts()
        }
        .navigationTitle("Избранное")
    }

    private func loadFavoriteProducts() {
        let favoriteNames = favouriteManager.getFavorites()
        let allProducts = serverDataModel.popularProducts
        
        favoriteProducts = allProducts.filter { favoriteNames.contains($0.name) }
    }

    private func removeFromFavorites(product: Product) {
        favouriteManager.removeFromFavorites(product: product)
        loadFavoriteProducts() // Обновляем список избранных после удаления
    }
}


