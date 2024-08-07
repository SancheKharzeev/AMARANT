//
//  HomeViewModel.swift
//  AMARANT
//
//  Created by Александр Х on 07.08.2024.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var banners: [Banner] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: String?
    @Published var popularProducts: [Product] = []
    @Published var categories: [Category] = []

    // Simulate loading data
    init() {
        loadBanners()
        loadPopularProducts()
        loadCategories()
    }
    
    func loadBanners() {
        banners = [
            Banner(id: UUID(),
                   imageUrl: "https://amarant.kz/almaty/image/cache/import_files/d0/d04e8cd19e5411eeab47d8bbc19d04f7_e90af2c09f2211eeab48d8bbc19d04f7-400x400.jpg",
                   link: "", title: "ПЕПТИДЫ"),
            Banner(id: UUID(),
                   imageUrl: "https://amarant.kz/almaty/image/cache/import_files/5d/5d794c5bbbf811edab36d8bbc19d04f7_8dd751caa08f11eeab48d8bbc19d04f7-400x400.jpeg",
                   link: "", title: "Trace Minerals"),
            Banner(id: UUID(),
                   imageUrl: "https://amarant.kz/almaty/image/cache/import_files/52/526e4d0f627911edaf610026182c78e3_fae35630320a11efab53d8bbc19d04f7-400x400.jpeg",
                   link: "", title: "Против ОРВИ"),
            Banner(id: UUID(),
                   imageUrl: "https://amarant.kz/astana/image/cache/import_files/68/68a819b61ced11efab51d8bbc19d04f7_9ca910cc295a11efab51d8bbc19d04f7-600x600.jpeg",
                   link: "", title: "НАНО-СЕРЕБРО")
        ]
    }
    
    func loadPopularProducts() {
        popularProducts = [
            createProduct(name: "EVITON Дигидрокверцитин", description: "EVITON Дигидрокверцитин+для МОЛОДОСТИ И КРАСОТЫ 30 капсул.", price: 3150, imageUrl: "https://amarant.kz/astana/image/cache/import_files/00/003ceade0d0611efab51d8bbc19d04f7_56072aa0295b11efab51d8bbc19d04f7-400x400.jpeg", category: "supplements"),
            createProduct(name: "REFOOD Дрожжи пищевые неактивные в хлопьях PREMIUM 100 гр.", description: "Fresh apple", price: 1990, imageUrl: "https://amarant.kz/astana/image/cache/import_files/f7/f70b3ed84adb11edaf5b0026182c78e3_11eba0d0a08711eeab48d8bbc19d04f7-220x220.jpeg", category: ""),
            createProduct(name: "Lunn Чёрная соль 200 гр.", description: "Fresh banana", price: 990, imageUrl: "https://amarant.kz/astana/image/cache/import_files/14/146282550d1e11efab51d8bbc19d04f7_f347f4bb229a11efab51d8bbc19d04f7-220x220.jpeg", category: ""),
            createProduct(name: "Fit Parad №8 Заменитель сахара на основе", description: "Fresh orange", price: 1490, imageUrl: "https://amarant.kz/astana/image/cache/import_files/9f/9f7c5157257c11e793fd001966967e40_23cf3d4ba08511eeab48d8bbc19d04f7-220x220.jpg", category: ""),
            createProduct(name: "Apple", description: "Fresh apple", price: 1990, imageUrl: "https://amarant.kz/astana/image/cache/import_files/f7/f70b3ed84adb11edaf5b0026182c78e3_11eba0d0a08711eeab48d8bbc19d04f7-220x220.jpeg", category: ""),
            createProduct(name: "Banana", description: "Fresh banana", price: 990, imageUrl: "https://amarant.kz/astana/image/cache/import_files/14/146282550d1e11efab51d8bbc19d04f7_f347f4bb229a11efab51d8bbc19d04f7-220x220.jpeg", category: ""),
            createProduct(name: "Acvelon Genius Kids 30 мл. (для нервной системы)", description: "Fresh orange", price: 1490, imageUrl: "https://amarant.kz/astana/image/cache/import_files/c2/c2325b39ba8011eeab49d8bbc19d04f7_8f8e3d3ec66d11eeab4ad8bbc19d04f7-220x220.png", category: ""),
            createProduct(name: "A BIO Витамин В9 30 мл", description: "Fresh orange", price: 2360, imageUrl: "https://amarant.kz/astana/image/cache/import_files/1a/1a0b1158959111eeab47d8bbc19d04f7_ab656f7bbf2e11eeab4ad8bbc19d04f7-220x220.png", category: ""),
            createProduct(name: "4Life Трансфер Фактор РиоВида Берст (15 саше)", description: "Fresh orange", price: 23490, imageUrl: "https://amarant.kz/astana/image/cache/import_files/7d/7d0f8edcb55411eeab49d8bbc19d04f7_8e58ec0c23d711efab51d8bbc19d04f7-220x220.jpeg", category: "")
        ]
    }
    
    func createProduct(name: String, description: String, price: Int, imageUrl: String, category: String) -> Product {
        let detailImages = Array(arrayLiteral: detailProduct(imageUrl: imageUrl), detailProduct(imageUrl: imageUrl), detailProduct(imageUrl: imageUrl), detailProduct(imageUrl: imageUrl))
        let descriptionImages = "Дигидрокверцетин – это мощный биофлавоноид, добывающийся из древесной части лиственницы сибирской. Обладает антиоксидантными и регенерирующими свойствами, превышающие известные природные аналоги (витамины А, C и др.) более чем в 10 раз. В комплексе с гиалуроновой кислотой, коэнзимом Q10 и витамином С усиливает свое положительное воздействие на процессы обновления клеток.\nПравильно подобранные компоненты состава стимулируют выработку коллагена и эластина, насыщают эпителий питательными элементами, ускоряют обменные процессы в организме, снимают воспалительные процессы, заживляют повреждения кожи, укрепляют ногти и волосы, улучшают текучесть крови и снимают покраснения, укрепляют стенки сосудов и капилляров, препятствуют появлению сосудистых сеточек и варикозу.\nУсиленная рецептура дигидрокверцетина \nНатуральные природные компоненты \nВысококачественное сырье Сибири и Алтая"
        return Product(name: name, description: descriptionImages, price: price, imageUrl: imageUrl, category: category, imagesOfProduct: detailImages)
    }

    func loadCategories() {
        categories = [
            Category(name: "Бакалея", imageUrl: "bakaleya" ),
            Category(name: "Бытовая химия", imageUrl: "bytovaya-himiya"),
            Category(name: "Веганское, \nрастительное", imageUrl: "veganskie-tovary"),
            Category(name: "Завтраки", imageUrl: "breakfast"),
            Category(name: "Замороженные продукты", imageUrl: "zamorozhennye-produkty"),
            Category(name: "Здоровье", imageUrl: "zdorove"),
            Category(name: "Консервация", imageUrl: "konservaciya"),
            Category(name: "Красота и гигиена", imageUrl: "krasota-i-zdorove"),
            Category(name: "Крупы, макароны, мука", imageUrl: "krupy-makarony-krupa"),
            Category(name: "Масла и соусы", imageUrl: "maslo-sousy"),
            Category(name: "Молочные продукты и яйцо", imageUrl: "molochnye-produkty-i-yajco"),
            Category(name: "Мороженое", imageUrl: "morozhennoe"),
            Category(name: "Напитки и детское питание", imageUrl: "napitki"),
            Category(name: "Орехи, чипсы и снеки", imageUrl: "orekhi-chipsy-sneki"),
            Category(name: "Пасты и Урбечи", imageUrl: "urbechi"),
            Category(name: "Сладости и здоровые десерты", imageUrl: "sladosti-i-zdorovye-deserty"),
            Category(name: "Сыры", imageUrl: "syry"),
            Category(name: "Хлеб и выпечка", imageUrl: "hleb-i-vypechka"),
            Category(name: "Чай, кофе, какао", imageUrl: "kofe-chaj-kakao")
        ]
    }
}


