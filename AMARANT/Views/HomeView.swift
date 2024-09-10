//
//  HomeView.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager
    
    // Фильтрация продуктов по выбранной категории (по подкатегориям)
    private func filteredProducts(for category: Category) -> [Product] {
        let subcategoryNames = category.subcategories.map { $0.name }
        return serverDataModel.catalogProducts.filter { subcategoryNames.contains($0.subCategory) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView(topColor: .orange, middleColor: .purple, bottomColor: .white)
                ZStack {
                    VStack {
                        HStack {
                            Image(systemName: "location.square.fill")
                                .foregroundStyle(.white)
                                .padding(.leading, 10)
                            if let city = viewModel.selectedCity {
                                Text("г. \(city.name). ")
                                    .font(.callout)
                                    .foregroundStyle(.white)
                            }
                            if let adress = viewModel.selectedAddress {
                                Text("\(adress.address)")
                                    .font(.callout)
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                        }
                        .padding(.top, 10)
                        BannerView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
                        SearchAndCatalogView(viewModel: viewModel)
                        ScrollView {
                            PopularProductView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
                            CategoryCard(viewModel: viewModel)
                                .padding()
                        }
                        .frame(height: 450)
                        Spacer()
                        // нижняя панель меню
                        GeometryReader { geometry in
                            HStack {
                                ButtonNavigBarView(image: Image(systemName: "person.crop.circle.fill"), action: {
                                    //code action
                                }, text: "Профиль")
                                .padding(.leading)
                                Spacer()
                                ButtonNavigBarView(image: Image(systemName: "fork.knife"), action: {
                                    viewModel.isShowingCatalog = true
                                }, text: "Каталог")
                                Spacer()
                                ButtonNavigBarView(image: Image(systemName: "heart.fill"), action: {
                                    viewModel.isShowingFavouriteProduct = true
                                }, text: "Избранное")
                                Spacer()
                                ButtonNavigBarView(image: Image(systemName: "house.fill"), action: {
                                    //code action
                                }, text: "Магазины")
                                Spacer()
                                ButtonNavigBarView(image: Image(systemName: "cart.fill"), action: {
                                    //code action
                                }, text: "Корзина")
                                .padding(.trailing)
                            }
                            .padding()
                            .background(Color.productPink)
                            .clipShape(Capsule())
                            .padding(.horizontal, 5)
                        }
                        .frame(height: 60)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.isShowingCatalog) {
            CatalogView(viewModel: viewModel)
        }
        .navigationDestination(isPresented: $viewModel.isShowingFavouriteProduct) {
            FavoriteProductsView(favouriteManager: favouriteManager, serverDataModel: serverDataModel)
        }
        // при нажатии на категорию CategoryCard срабатывает переключатель isShowingCategory на TRUE и открывается Лист с ProductDetailView
        .navigationDestination(isPresented: $viewModel.isShowingCategory) {
            let columns = [GridItem(.adaptive(minimum: 120), spacing: 20)]
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12, pinnedViews: .sectionHeaders) {
                        Section {
                            if let selectedCategory = viewModel.selectedCategory {                        ForEach(filteredProducts(for: selectedCategory), id: \.id) {
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
}
    
    
    struct BackgroundView: View {
        var topColor: Color
        var middleColor: Color
        var bottomColor: Color
        @State private var animateGradient: Bool = false
        
        var body: some View {
            Rectangle()
                .fill(LinearGradient(colors: [ topColor, middleColor, bottomColor],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .ignoresSafeArea()
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        }
    }
    
    struct SearchAndCatalogView: View {
        @ObservedObject var viewModel: HomeViewModel
        
        var body: some View {
            HStack{
                HStack{
                    // Поле для поиска товаров
                    Image(systemName: "magnifyingglass")
                    TextField("Найти продукты", text: $viewModel.searchText)
                }
                .padding(.all, 20)
                .background(.white)
                .clipShape(.capsule)
                .padding(.leading, 12)
                
                // Кнопка для выбора категории товаров
                Button(action: {
                    viewModel.isShowingCatalog = true
                }) {
                    Text("Категории")
                        .frame(width: 120, height: 62)
                        .foregroundColor(.white)
                        .background(Color(.productPink))
                        .cornerRadius(8)
                        .padding(.trailing, 8)
                }
            }
            .padding(.vertical, 8)
        }
    }
    
    struct ButtonNavigBarView: View {
        let image: Image
        let action: () -> Void
        let text: String
        
        var body: some View {
            VStack {
                Button(action: action) {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                        .background(Color.productPink)
                    
                }
                Text(text)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .lineLimit(1)
                    .fontDesign(.rounded)
                    .minimumScaleFactor(0.9)
            }
        }
    }

