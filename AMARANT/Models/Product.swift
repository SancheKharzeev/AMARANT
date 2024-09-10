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
    var price: Int
    var imageUrl: String
    var subCategory: String
    var imagesOfProduct: [detailProduct]
    var articul: Int
}

struct detailProduct: Identifiable, Codable {
    var id = UUID()
    var imageUrl: String
}
