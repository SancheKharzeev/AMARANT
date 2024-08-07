//
//  Order.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation

struct Order: Identifiable, Codable {
    var id: UUID
    var user: User
    var items: [CartItem]
    var total: Double
}
