//
//  AMARANTApp.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import SwiftUI

@main
struct AMARANTApp: App {
    @StateObject var viewModel = HomeViewModel()
    @StateObject var serverDataModel = ServerDataModel()
    @StateObject var favouriteManager = FavouriteManager()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel, serverDataModel: serverDataModel, favouriteManager: favouriteManager)
        }
    }
}
