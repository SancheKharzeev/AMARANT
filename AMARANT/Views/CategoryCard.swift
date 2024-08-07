//
//  CategoryCard.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//


import Foundation
import SwiftUI

struct CategoryCard: View {
    @StateObject private var viewModel = HomeViewModel()
    private var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20, pinnedViews: .sectionHeaders) {
            Section {
                ForEach(viewModel.categories, id: \.id) {
                    category in
                    ZStack(alignment: .topTrailing) {
                        ZStack(alignment: .bottom) {
                            //общая задняя плитка
                            Rectangle()
                                .fill(LinearGradient(colors: [.white, .white, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 180, height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 3)
                            
                            VStack {
                                ZStack(alignment: .top) {
                                    // задник для фотки
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 170, height: 170)
                                        .cornerRadius(10)
                                    //картинка
                                    Image(category.imageUrl)
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                        .cornerRadius(10)
                                    
//                                    if URL(string: category.imageUrl) != nil {
//                                        AsyncImage(url: URL(string: category.imageUrl)) { phase in
//                                            switch phase {
//                                            case .empty:
//                                                ProgressView()
//                                                    .frame(width: 170, height: 170)
//                                                    .background(Color.gray.opacity(0.2))
//                                                    .cornerRadius(10)
//                                            case .success(let image):
//                                                image
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .frame(width: 170, height: 170)
//                                                    .cornerRadius(10)
//                                            case .failure:
//                                                Color.red
//                                                    .frame(width: 100, height: 100)
//                                                    .cornerRadius(10)
//                                            @unknown default:
//                                                EmptyView()
//                                            }
//                                        }
//                                    } else {
//                                        Color.red
//                                            .frame(width: 100, height: 100)
//                                            .cornerRadius(10)
//                                    }
                                }
                                .shadow(radius: 3)
                                Spacer()
                                //название категории
                                Text(category.name)
                                    .font(.subheadline)
                                    .bold()
                                    .frame(width: 165, height: 50)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.primaryDark)
                            }
                            .padding(.top, 7)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                    }
                }
            }
        header: {
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 110, height: 30)
                        .foregroundStyle(.productPink)
                    .shadow(radius: 3)
                    Spacer()
                }
                Text("Категории")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white)
                    .padding(.leading, 12)
            }
            
        }
        }
    }
}


#Preview {
    CategoryCard()
}
