//
//  ProductResponse.swift
//  AMARANT
//
//  Created by Александр Х on 24.09.2024.
//
import Foundation

// Структура для парсинга данных, приходящих с сервера
struct ProductResponse: Codable {
    var name: String
    var description: String
    var price: Double
    var subCategoryName: String
    var subCategoryID: String
    var artiсul: String
    var storageName: String
    var storageID: String
    var count: Double
}

