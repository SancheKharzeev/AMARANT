//
//  CategoryView.swift
//  AMARANT
//
//  Created by Александр Х on 24.09.2024.
//

import SwiftUI
import Foundation

struct CategoryView: View {
    let selectedCategory: Category
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(selectedCategory.name)
                .font(.title)
                .padding(.bottom, 10)
                .padding(.leading, 8)
            
            List(selectedCategory.subcategories, id: \.subcategoryID) { subcategory in
                Button {
                    //action
                    print("Выбрана подкатегория: \(subcategory.name)")
                } label: {
                    Text(subcategory.name)
                        .font(.body)
                        .padding()
                }
                
            }
        }
    }
}

