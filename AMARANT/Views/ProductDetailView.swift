//
//  ProductDetailView.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    var product: Product
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
//                BackgroundView(topColor: .yellow, middleColor: .purple, bottomColor: .yellow)
                Rectangle()
                    .fill(LinearGradient(colors: [ .yellow, .purple, .yellow],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                ZStack {
                    VStack {
                        ImageDetailProduct(selectedProduct: product)
                        MenuDescriptionDetailProduct(product: product)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    ProductDetailView(product: Product(
        name: "Stamakort",
        description: "Дигидрокверцетин – это мощный биофлавоноид, добывающийся из древесной части лиственницы сибирской. Обладает антиоксидантными и регенерирующими свойствами, превышающие известные природные аналоги (витамины А, C и др.) более чем в 10 раз. В комплексе с гиалуроновой кислотой, коэнзимом Q10 и витамином С усиливает свое положительное воздействие на процессы обновления клеток.\nПравильно подобранные компоненты состава стимулируют выработку коллагена и эластина, насыщают эпителий питательными элементами, ускоряют обменные процессы в организме, снимают воспалительные процессы, заживляют повреждения кожи, укрепляют ногти и волосы, улучшают текучесть крови и снимают покраснения, укрепляют стенки сосудов и капилляров, препятствуют появлению сосудистых сеточек и варикозу.\nУсиленная рецептура дигидрокверцетина \nНатуральные природные компоненты \nВысококачественное сырье Сибири и Алтая",
        price: 132400,
        imageUrl: "https://amarant.kz/image/cache/import_files/f7/f70b3ed84adb11edaf5b0026182c78e3_11eba0d0a08711eeab48d8bbc19d04f7-220x220.jpeg",
        category: "supplements",
        imagesOfProduct: [detailProduct(imageUrl: "https://amarant.kz/image/cache/import_files/f7/f70b3ed84adb11edaf5b0026182c78e3_11eba0d0a08711eeab48d8bbc19d04f7-220x220.jpeg"),
                          detailProduct(imageUrl: "https://amarant.kz/image/cache/import_files/f7/f70b3ed84adb11edaf5b0026182c78e3_11eba0d0a08711eeab48d8bbc19d04f7-220x220.jpeg"),
                          detailProduct(imageUrl: "https://amarant.kz/image/cache/import_files/f7/f70b3ed84adb11edaf5b0026182c78e3_11eba0d0a08711eeab48d8bbc19d04f7-220x220.jpeg")
                         ]
    )
    )
}

struct MenuDescriptionDetailProduct: View {
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .bold()
            HStack {
                ZStack {
                    Rectangle()
                        .frame(width: 140, height: 50)
                        .foregroundStyle(.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 1)
                        .shadow(radius: 5)
                    // ценник
                    HStack {
                        Text("\(product.price)")
                            .font(.title)
                            .bold()
                        Image(systemName: "tengesign")
                            .resizable()
                            .frame(width: 10, height: 13)
                    }
                    .foregroundStyle(.white)
                }
                Spacer()
                //кнопка Корзины
                Button {
                    print("Товар \(product.name) Добавлен в Корзину")
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 155, height: 50)
                            .foregroundStyle(LinearGradient(colors: [.yellow, .purple, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        
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
                .shadow(radius: 5)
            }
        }
        .padding(8)
        .frame(width: 370, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3)
        
        // Описание товара
        
        DescriptionOfProduct(product: product)
        
        
        
    }
}

struct ImageDetailProduct: View {
    @StateObject private var viewModel = HomeViewModel()
    var selectedProduct: Product
    
    var body: some View {
        TabView {
            ForEach(selectedProduct.imagesOfProduct) { detail in
                if let url = URL(string: detail.imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 370, height: 370)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 360, height: 360)
                                .cornerRadius(10)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 360, height: 360)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Color.red
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 375)
    }
}

struct DescriptionOfProduct: View {
    var product: Product
    @State private var isExpanded = false
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .frame(height: isExpanded ? 270 : 100)
                    .foregroundColor(.white)
                
                ScrollView(.vertical, showsIndicators: true) {
                    Text(product.description)
                        .padding(.horizontal)
                }
                .frame(height: isExpanded ? 260 : 90)
                
            }
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text(isExpanded ? "Свернуть" : "Развернуть")
                        .frame(width: 110, height: 35)
                        .background(Color.purple.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.trailing, 10)
            }
        }
    }
}



