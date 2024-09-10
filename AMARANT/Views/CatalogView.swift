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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Каталог товаров")
                    .font(.title)
                    .bold()
                    .fontDesign(.rounded)
                    .padding(.top, -30)
                List {
                    ForEach(viewModel.categories) { category in
                        DisclosureGroup(category.name) {
                            ForEach(category.subcategories, id: \.self) {
                                subcategory in
                                NavigationLink(destination: SubcategoryView(subcategoryId: subcategory.id)) {
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
    let subcategoryId: UUID

    var body: some View {
        Text("Выбрана подкатегория с ID: \(subcategoryId)")
    }
}


