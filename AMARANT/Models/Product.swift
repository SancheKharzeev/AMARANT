//
//  Product.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI

struct Product: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var price: Double 
    var imageUrl: String
    var subCategoryName: String
    var subCategoryID: String
    var imagesOfProduct: [detailProduct]
    var articul: String
    var count: Double
    var storageName: String
    var storageID: String
}

struct detailProduct: Identifiable, Codable {
    var id = UUID()
    var imageUrl: String
}
