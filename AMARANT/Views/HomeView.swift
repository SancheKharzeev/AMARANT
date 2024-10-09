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

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView(topColor: .orange, middleColor: .purple, bottomColor: .white)
                VStack {
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
                        .frame(height: UIScreen.main.bounds.height * 0.5) // 50% высоты экрана
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    FooterView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.bottom, 8)
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

struct FooterView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager

    var body: some View {
        NavigationStack {
            // нижняя панель меню
            GeometryReader { geometry in
                HStack {
                    ButtonNavigBarView(image: Image(systemName: "text.magnifyingglass"), action: {
                        viewModel.isShowingCatalog.toggle()
                    }, text: "Каталог")
                    .padding(.leading)
                    Spacer()
                    ButtonNavigBarView(image: Image(systemName: "cart.fill"), action: {
                        //code action
                    }, text: "Корзина")
                    Spacer()
                    ButtonNavigBarView(image: Image(systemName: "person.crop.circle.fill"), action: {
                        viewModel.isShowingProfile.toggle()
                    }, text: "Профиль")
                    .padding(.trailing)
                }
                .padding()
                .background(Color.productPink)
                .clipShape(Capsule())
                .padding(.horizontal, 5)
            }
            .frame(height: 60)
        }
        // Добавляем отступ для нижней панели, учитывая безопасную область экрана
        .padding(.bottom, 5)
        .safeAreaPadding(.bottom)

        // кнопка Main в футтере
        .navigationDestination(isPresented: $viewModel.isShowingMain) {
            HomeView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
        }
        // кнопка каталога в футтере
        .navigationDestination(isPresented: $viewModel.isShowingCatalog) {
            CatalogView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
        }
        // кнопка Profile в футтере
        .navigationDestination(isPresented: $viewModel.isShowingProfile) {
            ProfileView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
        }
        // при нажатии на категорию CategoryCard срабатывает переключатель isShowingCategory на TRUE и открывается Лист с ProductDetailView
        .navigationDestination(isPresented: $viewModel.isShowingCategory) {
            if let selectedCategory = viewModel.selectedCategory {
                CategoryView(selectedCategory: selectedCategory)
            }
        }
    }
}
