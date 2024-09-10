//
//  BannerView.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct BannerView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager

    @State private var isShowingBanner: Bool = false
    @State private var selectedBanner: Banner?
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    ForEach(viewModel.banners) { banner in
                        ZStack {
                            Image(banner.imageUrl)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 3)
                            VStack {
                                Spacer()
                                Text("\(banner.title)")
                                    .font(.title2)
                                    .fontDesign(.rounded)
                                    .bold()
                                    .frame(width: 250, height: 50)
                                    .foregroundStyle(.white)
                                    .background(.gold)
                                    .cornerRadius(10)
                            }
                        }
                        .onTapGesture {
                            selectedBanner = banner
                            isShowingBanner = true
                        }
                    }
                }
            }
            .frame(height: 150)
            .padding(.leading, 8)
            .navigationDestination(isPresented: $isShowingBanner) {
                if let selectedBanner = selectedBanner {
                    BannerDetailView(banner: selectedBanner, viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
                }
            }
        }
        
    }
}


struct BannerDetailView: View {
    var banner: Banner
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager

    var body: some View {
        VStack {
            if let url = URL(string: banner.imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 390, height: 150)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.horizontal, 5)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 390, height: 150)
                            .cornerRadius(10)
                            .padding(.horizontal, 5)
                    case .failure:
                        Image(banner.imageUrl)
                            .frame(width: 390, height: 150)
                            .cornerRadius(10)
                            .padding(.horizontal, 5)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            Text(banner.title)
                .font(.largeTitle)
                .padding()
            Text("Описание рекламного баннера продукта. Перечень фотографий и внизу ссылки на товар.")
                .font(.title2)
                .padding()
            // Add more details about the banner here if needed
            PopularProductView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
            Spacer()
        }
        .navigationTitle(banner.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

