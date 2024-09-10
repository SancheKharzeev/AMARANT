//
//  ContentView.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var serverDataModel: ServerDataModel
    @ObservedObject var favouriteManager: FavouriteManager

    
    var body: some View {
        NavigationStack {
            if viewModel.isStoreSelected {
                HomeView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
            } else {
                SelectStoreView(viewModel: viewModel)
            }
        }
    }
}
