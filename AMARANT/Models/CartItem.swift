//
//  CartItem.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation

struct CartItem: Identifiable, Codable {
    var id = UUID()
    var product: Product
    var quantity: Int
}
