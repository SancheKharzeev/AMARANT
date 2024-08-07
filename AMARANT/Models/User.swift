//
//  User.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID
    var name: String
    var email: String
}
