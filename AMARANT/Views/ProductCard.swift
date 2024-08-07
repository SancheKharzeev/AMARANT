//
//  ProductCard.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct ProductCard: View {
    var product: Product
    var favouriteManager = FavouriteManager()
    @State private var isFavorite = false
    
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(LinearGradient(colors: [.white, .white, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 180, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3)
                
                VStack {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 170, height: 170)
                            .cornerRadius(10)
                        
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
                            Spacer()
                            ProductAddToFavButton(product: product)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .bold()
                        HStack {
                            Text("\(product.price)")
                                .font(.subheadline)
                            Image(systemName: "tengesign")
                                .resizable()
                                .frame(width: 10, height: 13)
                        }
                        
                        ProductAddToCartButton(product: product)
                    }
                    .padding(8)
                    .frame(width: 170, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3)
                    Spacer()
                    
                    
                }
                .frame(width: 170, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .onAppear {
            isFavorite = favouriteManager.checkIfFavorite(product: product)
        }
    }
}



struct ProductAddToCartButton: View {
    var product: Product
    var body: some View {
        Button {
            print("Товар \(product.name) Добавлен в Корзину")
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 155, height: 37)
                    .foregroundStyle(LinearGradient(colors: [.yellow, .purple, .productPink], startPoint: .topLeading, endPoint: .bottomTrailing))
                HStack {
                    Image(systemName: "cart.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .scaledToFit()
                        .foregroundStyle(.white)
                    Text("ДОБАВИТЬ")
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                }
            }
        }
    }
}

struct ProductAddToFavButton: View {
    var favouriteManager = FavouriteManager()
    @State private var isFavorite = false
    var product: Product
    
    var body: some View {
        Button {
            isFavorite.toggle()
            if isFavorite {
                favouriteManager.addToFavorites(product: product)
            } else {
                favouriteManager.removeFromFavorites(product: product)
            }
        } label: {
            ZStack{
                Circle()
                    .frame(width: 30)
                    .foregroundStyle(isFavorite ?
                                     LinearGradient(colors: [.yellow, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing) :
                                        LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .scaledToFit()
                    .padding(12)
                    .foregroundColor(isFavorite ? .purple : .white)
                    .padding(.top, 3)
                
            }
        }
    }
}


class FavouriteManager {
    func addToFavorites(product: Product) {
        var favorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []
        favorites.append(product.name)
        UserDefaults.standard.set(favorites, forKey: "favorites")
        print("Товар \(product.name) добавлен в избранное")
    }
    func removeFromFavorites(product: Product) {
        var favorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []
        if let index = favorites.firstIndex(of: product.name) {
            favorites.remove(at: index)
        }
        UserDefaults.standard.set(favorites, forKey: "favorites")
        print("Товар \(product.name) удален из избранного")
    }
    
    func checkIfFavorite(product: Product) -> Bool {
        let favorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []
        return favorites.contains(product.name)
    }
}
