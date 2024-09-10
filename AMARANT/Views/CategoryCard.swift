//
//  CategoryCard.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//


import Foundation
import SwiftUI

struct CategoryCard: View {
    @ObservedObject var viewModel: HomeViewModel
    var columns = [GridItem(.adaptive(minimum: 130), spacing: 20)]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12, pinnedViews: .sectionHeaders) {
            Section {
                ForEach(viewModel.categories, id: \.id) {
                    category in
                    ZStack(alignment: .topTrailing) {
                        ZStack(alignment: .bottom) {
                            //общая задняя рамка
                            Rectangle()
                                .fill(LinearGradient(colors: [.white, .white, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 178, height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 3)
                            VStack {
                                ZStack(alignment: .top) {
                                    // белый задник для фотки
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 170, height: 170)
                                        .cornerRadius(10)
                                    //картинка и кнопка
                                    Button {
                                        viewModel.isShowingCategory = true
                                        viewModel.selectedCategory = category
                                    } label: {
                                        Image(category.categImageUrl)
                                            .resizable()
                                            .frame(width: 169, height: 169)
                                            .cornerRadius(10)
                                    }
                                }
                                .shadow(radius: 3)
                                Spacer()
                                //название категории
                                Text(category.name)
                                    .font(.subheadline)
                                    .fontDesign(.rounded)
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


// Представление для одной категории
struct CategoryView: View {
    let category: Category
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Text("Catalog")
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            
            Text(category.name)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}
