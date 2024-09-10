//
//  Category.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation

struct Category: Identifiable, Codable {
    var id = UUID()
    var name: String
    var categImageUrl: String
    var subcategories: [Subcategory]
}

struct Subcategory: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
}

