//
//  BannerView.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct BannerView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isShowingBanner: Bool = false
    @State private var selectedBanner: Banner?
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    ForEach(viewModel.banners) { banner in
                        ZStack {
                            if URL(string: banner.imageUrl) != nil {
                                AsyncImage(url: URL(string: banner.imageUrl)) { phase in
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
                                            .frame(width: 250, height: 150)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .padding(.horizontal, 5)
                                    case .failure:
                                        Color.red
                                            .frame(width: 390, height: 150)
                                            .cornerRadius(10)
                                            .padding(.horizontal, 5)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
//                            RoundedRectangle(cornerRadius: 10)
//                                .frame(minWidth: 100, maxHeight: 35)
//                                .foregroundStyle(.productPink)
                            VStack {
                                Spacer()
                                Text("\(banner.title)")
                                    .font(.title2)
                                    .fontDesign(.rounded)
                                    .bold()
                                    .frame(width: 250, height: 50)
                                    .foregroundStyle(.white)
                                .background(.gold)
                            }
                        }
                        .onTapGesture {
                            selectedBanner = banner
                            isShowingBanner = true
                        }
                    }
                }
//                .scrollTargetLayout()
            }
//            .scrollTargetBehavior(.viewAligned)
            .frame(height: 150)
            .padding(.leading, 8)
            .navigationDestination(isPresented: $isShowingBanner) {
                if let selectedBanner = selectedBanner {
                    BannerDetailView(banner: selectedBanner)
                }
            }
        }
        
    }
}


struct BannerDetailView: View {
    var banner: Banner
    
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
                        Color.red
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
            
            // Add more details about the banner here if needed
            
            Spacer()
        }
        .navigationTitle(banner.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    BannerView()
}
