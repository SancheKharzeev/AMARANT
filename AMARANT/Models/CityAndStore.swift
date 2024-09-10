//
//  CityAndStore.swift
//  AMARANT
//
//  Created by Александр Х on 08.08.2024.
//

import Foundation

struct City: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let stores: [Store]
}

struct Store: Identifiable, Hashable {
    let id = UUID()
    let address: String
}
