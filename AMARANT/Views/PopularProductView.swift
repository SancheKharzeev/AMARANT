//
//  PopularProductView.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct PopularProductView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isShowingDetail = false
    @State private var selectedProduct: Product?

    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.popularProducts) { product in
                        ProductCard(product: product)
                            .onTapGesture {
                                selectedProduct = product
                                isShowingDetail = true
                            }
                    }
                }
//                .scrollTargetLayout()
                .padding(.leading, 12)
            }
//            .scrollTargetBehavior(.viewAligned)
            .navigationDestination(isPresented: $isShowingDetail) {
                if let selectedProduct = selectedProduct {
                    ProductDetailView(product: selectedProduct)
                } else {
                    Text("No product selected")
                }
            }
        }
    }
}


#Preview {
    PopularProductView()
}
