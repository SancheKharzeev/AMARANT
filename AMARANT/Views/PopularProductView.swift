//
//  PopularProductView.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct PopularProductView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager

    @State private var isShowingDetail = false
    @State private var selectedProduct: Product?

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 190, height: 30)
                        .foregroundStyle(.productPink)
                        .shadow(radius: 3)
                        .padding(.leading, 12)
                    Spacer()
                }
                HStack {
                    Text("Популярные товары")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.leading, 21)
                        .shadow(radius: 3)
                    Spacer()
                }
            }
            
            NavigationStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(serverDataModel.popularProducts) { product in
                            ProductCard(product: product, favouriteManager: favouriteManager, viewModel: viewModel)
                                .onTapGesture {
                                    selectedProduct = product
                                    isShowingDetail = true
                                }
                        }
                    }
                    //                .scrollTargetLayout()
                    .padding(.leading, 12)
                }
                //            .scrollTargetBehavior(.viewAligned)
                .navigationDestination(isPresented: $isShowingDetail) {
                    if let selectedProduct = selectedProduct {
                        ProductDetailView(product: selectedProduct, viewModel: viewModel, favouriteManager: favouriteManager)
                    } else {
                        Text("No product selected")
                    }
                }
            }
        }
    }
}


