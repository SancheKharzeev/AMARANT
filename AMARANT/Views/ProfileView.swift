//
//  ProfileView.swift
//  AMARANT маркет
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager

    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack{
                BackgroundView(topColor: .orange, middleColor: .purple, bottomColor: .white)
                VStack{
                    ScrollView {
                        VStack(alignment: .leading, spacing: 18) {
                            headerContainer
                            stuckButton
                            PopularProductView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
                        }
//                        .padding()
                    }
//                    FooterView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
                }
            }
        }
        // кнопка избранное в футтере
        .navigationDestination(isPresented: $viewModel.isShowingFavouriteProduct) {
            FavoriteProductsView(favouriteManager: favouriteManager, serverDataModel: serverDataModel)
        }
    }
    

    var headerContainer: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                TextField("Искать", text: $searchText)
                    .padding(10)
                    .padding(.leading, 18)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .overlay {
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                                .padding(.leading, 4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
            }
            .padding()
            Text("Фамилия Имя")
                .font(.title)
                .foregroundColor(.white) // Change the text color to contrast with the background
                .padding(.horizontal)
           
            HStack {
                CustomProfileButtonView(imageName: "heart.fill", title: "Избранное", subtitle: "40", action: {
                    viewModel.isShowingFavouriteProduct = true
                }, isFavorite: true)
                
                CustomProfileButtonView(imageName: "cart.fill", title: "Покупки", subtitle: "Заказать снова", action: {
                    viewModel.isShowingFavouriteProduct = true
                }, isFavorite: true)
            }
        }
        .background(Color.productPink)
        .cornerRadius(32)
        .frame(height: 300)
        .padding(.horizontal, 4)
//        .padding(.leading, -28)
//        .padding(.trailing, -28)
//        .padding(.top, -20)
    }
    
    
    var stuckButton: some View {
        VStack(alignment: .center) {
            SettingsButton(title: "Настройки", action: {
                // action
            }, icon: "chevron.forward")
            SettingsButton(title: "Язык", action: {
                // action
            }, icon: "chevron.forward")
            SettingsButton(title: "О приложении", action: {
                // action
            }, icon: "chevron.forward")
            SettingsButton(title: "Помощь", action: {
                // action
            }, icon: "chevron.forward")
            
        }
        .frame(maxWidth: .infinity)
        .padding(.top, -10)
        .padding(.horizontal, 4)
        .background(Color.primaryPink.opacity(0.4))
    }
    
}

struct SettingsButton: View {
    let title: String
    let action: () -> Void
    let icon: String
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Text(title)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: icon)
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.productPink)
            .cornerRadius(16)
        }
    }
}

struct CustomProfileButtonView: View {
    let imageName: String
    let title: String
    let subtitle: String
    let action: () -> Void
    let isFavorite: Bool
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack(alignment: .leading) {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gold)
                Spacer()
                
                Text(title)
                    .font(.body)
                    .foregroundColor(isFavorite ? .productPink : .black) // Используем цвет для избранного
                Spacer()
                
                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(.gray)
                    .opacity(0.7)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}
