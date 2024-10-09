//
//  CatalogView.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//
import SwiftUI

import Foundation

struct CatalogView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager

    var body: some View {
        NavigationView {
            VStack {
                Text("Каталог товаров")
                    .font(.title)
                    .bold()
                    .fontDesign(.rounded)
                    .padding(.top, -20)
                List {
                    ForEach(viewModel.categories) { category in
                        DisclosureGroup(category.name) {
                            ForEach(category.subcategories, id: \.self) {
                                subcategory in
                                NavigationLink(destination: SubcategoryView(subcategoryName: subcategory,
                                                                            viewModel: viewModel,
                                                                            serverDataModel: serverDataModel,
                                                                            favouriteManager: favouriteManager)
                                ) {
                                    Text(subcategory.name)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}

struct SubcategoryView: View {
    let subcategoryName: Subcategory
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager

    // Фильтрация продуктов по выбранной категории (по подкатегориям)
    private func filteredProducts(for subcategory: Subcategory) -> [Product] {
        let subcategoryNames = subcategory.name
        return serverDataModel.catalogProducts.filter { subcategoryNames.contains($0.subCategoryName) }
    }
    
    var body: some View {
        let columns = [GridItem(.adaptive(minimum: 120), spacing: 20)]
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12, pinnedViews: .sectionHeaders) {
                    Section {
                        // фильтрация товара по категориям
                        
                            ForEach(filteredProducts(for: subcategoryName), id: \.id) {
                            product in
                            ProductCard(product: product, favouriteManager: favouriteManager, viewModel: viewModel)
                                .onTapGesture {
                                    viewModel.selectedProduct = product
                                    viewModel.isShowingCatalogProduct = true
                                
                        }
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.isShowingCatalogProduct) {
            if let selectedProductDetail = viewModel.selectedProduct {
                ProductDetailView(product: selectedProductDetail, viewModel: viewModel, favouriteManager: favouriteManager)
            } else {
                Text("No product selected")
            }
        }
    }
}


