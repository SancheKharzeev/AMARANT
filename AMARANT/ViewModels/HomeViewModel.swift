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
    @Published var selectedCategory: Category?
    @Published var categories: [Category] = []
    
    // Simulate loading data
    init() {
        loadBanners()
        loadCategories()
    }
    
    // MARK: Баннеры
    func loadBanners() {
        banners = [
            Banner(imageUrl: "peptidy",
                   link: "", title: "ПЕПТИДЫ"),
            Banner(imageUrl: "trace",
                   link: "", title: "Trace Minerals"),
            Banner(imageUrl: "orvi",
                   link: "", title: "Против ОРВИ"),
            Banner(imageUrl: "silverceuticals",
                   link: "", title: "НАНО-СЕРЕБРО")
        ]
    }
    
    // MARK: Категории
    func loadCategories() {
        categories = [
            Category(
                categoryID: "de56ff8a-374c-11ee-ab45-d8bbc19d04f7", name: "Бакалея",
                categImageUrl: "bakaleya",
                subcategories: [
                    Subcategory(subcategoryID: "addc13e3-3bef-11ee-ab45-d8bbc19d04f7", name: "Заменитель сахара"),
                    Subcategory(subcategoryID: "3f7f3dcc-3bef-11ee-ab45-d8bbc19d04f7", name: "Ингредиенты для выпечки"),
                    Subcategory(subcategoryID: "f2646668-374c-11ee-ab45-d8bbc19d04f7", name: "Сахар, соль, специи")
                ]
            ),
            Category(
                categoryID: "df2dbd42-d61b-11ee-ab4c-d8bbc19d04f7", name: "Бытовая химия",
                categImageUrl: "bytovaya-himiya",
                subcategories: [
                    Subcategory(subcategoryID: "e4f07152-374b-11ee-ab45-d8bbc19d04f7", name: "Бытовая химия и товары для дома"),
                    Subcategory(subcategoryID: "fa6ca10d-d61b-11ee-ab4c-d8bbc19d04f7", name: "Средства для стирки")
                ]
            ),
            Category(
                categoryID: "05aea765-3670-11ee-ab45-d8bbc19d04f7", name: "Веганское, растительное",
                categImageUrl: "veganskie-tovary",
                subcategories: [
                    Subcategory(subcategoryID: "3a24fab6-3683-11ee-ab45-d8bbc19d04f7", name: "Вместо молока"),
                    Subcategory(subcategoryID: "6f4d99ee-36b7-11ee-ab45-d8bbc19d04f7", name: "Паштеты"),
                    Subcategory(subcategoryID: "c3b93112-36b7-11ee-ab45-d8bbc19d04f7", name: "Растительный белок")
                ]
            ),
            Category(
                categoryID: "8aa99d56-65ef-11ee-ab46-d8bbc19d04f7", name: "Завтраки",
                categImageUrl: "breakfast",
                subcategories: [
                    Subcategory(subcategoryID: "9966fef3-65ef-11ee-ab46-d8bbc19d04f7", name: "Отруби, семена и клетчатка"),
                    Subcategory(subcategoryID: "34e4980c-3693-11ee-ab45-d8bbc19d04f7", name: "Сухие завтраки, хлопья, мюсли")
                ]
            ),
            Category(
                categoryID: "1a42ea96-366d-11ee-ab45-d8bbc19d04f7", name: "Замороженные продукты",
                categImageUrl: "zamorozhennye-produkty",
                subcategories: [
                    Subcategory(subcategoryID: "", name: "Замороженные фрукты, овощи, грибы"),
                    Subcategory(subcategoryID: "", name: "Мясная продукция"),
                    Subcategory(subcategoryID: "", name: "Пельмени, манты, вареники, выпечка")
                ]
            ),
            Category(
                categoryID: "398a9e21-3694-11ee-ab45-d8bbc19d04f7", name: "Здоровье",
                categImageUrl: "zdorove",
                subcategories: [
                    Subcategory(subcategoryID: "16515b7d-36c6-11ee-ab45-d8bbc19d04f7", name: "Витамины, БАД"),
                    Subcategory(subcategoryID: "37822b37-d20d-11ee-ab4c-d8bbc19d04f7", name: "Для детей"),
                    Subcategory(subcategoryID: "44cf23ad-3694-11ee-ab45-d8bbc19d04f7", name: "Спортивное питание"),
                    Subcategory(subcategoryID: "5931551c-3bf2-11ee-ab45-d8bbc19d04f7", name: "Фитосвечи")
                ]
            ),
            Category(
                categoryID: "9348dc26-366f-11ee-ab45-d8bbc19d04f7", name: "Консервация",
                categImageUrl: "konservaciya",
                subcategories: [
                    Subcategory(subcategoryID: "ac61c519-366f-11ee-ab45-d8bbc19d04f7", name: "Варенье и джемы"),
                    Subcategory(subcategoryID: "b3239d7c-3681-11ee-ab45-d8bbc19d04f7", name: "Оливки и маслины"),
                    Subcategory(subcategoryID: "8471a11d-3681-11ee-ab45-d8bbc19d04f7", name: "Томатные пасты"),
                    Subcategory(subcategoryID: "a8dbce6b-c1b5-11ee-ab4a-d8bbc19d04f7", name: "Рыбные консервы"),
                    Subcategory(subcategoryID: "e99b475b-3bef-11ee-ab45-d8bbc19d04f7", name: "Уксус"),
                    Subcategory(subcategoryID: "6927288a-36c1-11ee-ab45-d8bbc19d04f7", name: "Фрукты, овощи, морские водоросли")
                ]
            ),
            Category(
                categoryID: "97a6d4e3-35ca-11ee-ab45-d8bbc19d04f7", name: "Красота и гигиена",
                categImageUrl: "krasota-i-zdorove",
                subcategories: [
                    Subcategory(subcategoryID: "7a5830c6-35f5-11ee-ab45-d8bbc19d04f7", name: "Мочалки, щетки, пилки"),
                    Subcategory(subcategoryID: "8baff925-36c4-11ee-ab45-d8bbc19d04f7", name: "Гели для душа"),
                    Subcategory(subcategoryID: "9c6a72e9-36c4-11ee-ab45-d8bbc19d04f7", name: "Бомбочки, пена и соль для ванн"),
                    Subcategory(subcategoryID: "a69b5c28-36c4-11ee-ab45-d8bbc19d04f7", name: "Косметика и уход")
                ]
            ),
            Category(
                    categoryID: "6cc328c1-35ca-11ee-ab45-d8bbc19d04f7",
                    name: "Крупы, макароны, мука",
                    categImageUrl: "krupy-makarony-krupa",
                    subcategories: [
                        Subcategory(subcategoryID: "3f92b5d4-3693-11ee-ab45-d8bbc19d04f7", name: "Каши"),
                        Subcategory(subcategoryID: "689bb88a-37f4-11ee-ab45-d8bbc19d04f7", name: "Крупы"),
                        Subcategory(subcategoryID: "3f92b5d1-3693-11ee-ab45-d8bbc19d04f7", name: "Макароны"),
                        Subcategory(subcategoryID: "c65f0755-3682-11ee-ab45-d8bbc19d04f7", name: "Мука"),
                        Subcategory(subcategoryID: "07944b4a-3b5a-11ee-ab45-d8bbc19d04f7", name: "Супы")
                    ]
                ),
            Category(
                    categoryID: "898b1ddb-35ca-11ee-ab45-d8bbc19d04f7",
                    name: "Масла и соусы",
                    categImageUrl: "maslo-sousy",
                    subcategories: [
                        Subcategory(subcategoryID: "a6b0b579-37f6-11ee-ab45-d8bbc19d04f7", name: "Масло ГХИ и сливочное"),
                        Subcategory(subcategoryID: "c073c881-3683-11ee-ab45-d8bbc19d04f7", name: "Растительные масла"),
                        Subcategory(subcategoryID: "63ecac2f-3670-11ee-ab45-d8bbc19d04f7", name: "Соусы и специи")
                    ]
                ),
            Category(
                    categoryID: "82a199ab-36c5-11ee-ab45-d8bbc19d04f7",
                    name: "Молочные продукты и яйцо",
                    categImageUrl: "molochnye-produkty-i-yajco",
                    subcategories: [
                        Subcategory(subcategoryID: "987999e5-36c5-11ee-ab45-d8bbc19d04f7", name: "Из козьего, кобыльего и овечьего молока"),
                        Subcategory(subcategoryID: "molochnye-produkty-i-yajco", name: "Молоко, кефир, йогурт")
                    ]
                ),
            Category(
                categoryID: "dc9ab12c-36c5-11ee-ab45-d8bbc19d04f7", name: "Мороженое",
                categImageUrl: "morozhennoe",
                subcategories: [
                    Subcategory(subcategoryID: "ef3b8294-36c5-11ee-ab45-d8bbc19d04f7", name: "Мороженое")
                ]
            ),
            Category(
                categoryID: "2a2ff475-3682-11ee-ab45-d8bbc19d04f7", name: "Напитки и детское питание",
                categImageUrl: "napitki",
                subcategories: [
                    Subcategory(subcategoryID: "f6b41604-b369-11ee-ab49-d8bbc19d04f", name: "Детское питание и смеси"),
                    Subcategory(subcategoryID: "d81c7733-37f9-11ee-ab45-d8bbc19d04f7", name: "Комбуча"),
                    Subcategory(subcategoryID: "30d11c07-3682-11ee-ab45-d8bbc19d04f7", name: "Компоты и кисели"),
                    Subcategory(subcategoryID: "87435551-37f9-11ee-ab45-d8bbc19d04f7", name: "Минеральная вода"),
                    Subcategory(subcategoryID: "bdc0a826-36b8-11ee-ab45-d8bbc19d04f7", name: "Соки, смузи")
                    
                ]
            ),
            Category(
                categoryID: "da3602c5-35cb-11ee-ab45-d8bbc19d04f7", name: "Орехи, чипсы и снеки",
                categImageUrl: "orekhi-chipsy-sneki",
                subcategories: [
                    Subcategory(subcategoryID: "fbd5a023-3693-11ee-ab45-d8bbc19d04f7", name: "Орехи"),
                    Subcategory(subcategoryID: "037b112f-3694-11ee-ab45-d8bbc19d04f7", name: "Попкорн"),
                    Subcategory(subcategoryID: "037b1132-3694-11ee-ab45-d8bbc19d04f7", name: "Снеки"),
                    Subcategory(subcategoryID: "0d5749a9-3694-11ee-ab45-d8bbc19d04f7", name: "Сухофрукты"),
                    Subcategory(subcategoryID: "0d5749ac-3694-11ee-ab45-d8bbc19d04f7", name: "Чипсы")
                ]
            ),
            Category(
                categoryID: "a1755948-37f5-11ee-ab45-d8bbc19d04f7", name: "Пасты и Урбечи",
                categImageUrl: "urbechi",
                subcategories: [
                    Subcategory(subcategoryID: "fe43eaa3-37f5-11ee-ab45-d8bbc19d04f7", name: "Пасты и Урбечи")
                ]
            ),
            Category(
                categoryID: "3a8970de-31bd-11ee-ab44-d8bbc19d04f7", name: "Сладости и здоровые десерты",
                categImageUrl: "sladosti-i-zdorovye-deserty",
                subcategories: [
                    Subcategory(subcategoryID: "b02efc0c-35d5-11ee-ab45-d8bbc19d04f7", name: "Вафли и пряники"),
                    Subcategory(subcategoryID: "97f6ea3f-35f5-11ee-ab45-d8bbc19d04f7", name: "Конфеты и карамель"),
                    Subcategory(subcategoryID: "602d184d-35d3-11ee-ab45-d8bbc19d04f7", name: "Мармелад, зефир, пастила"),
                    Subcategory(subcategoryID: "290d93e2-35d5-11ee-ab45-d8bbc19d04f7", name: "Мед, сиропы и сгущенка"),
                    Subcategory(subcategoryID: "33927003-366c-11ee-ab45-d8bbc19d04f7", name: "Печенье"),
                    Subcategory(subcategoryID: "89e25c3c-3699-11ee-ab45-d8bbc19d04f7", name: "Пирожные и десерты"),
                    Subcategory(subcategoryID: "e9a88ce5-3692-11ee-ab45-d8bbc19d04f7", name: "Чурчхела"),
                    Subcategory(subcategoryID: "ce63f4e7-35d4-11ee-ab45-d8bbc19d04f7", name: "Шоколад и батончики")
                ]
            ),
            Category(
                categoryID: "027cd800-36b7-11ee-ab45-d8bbc19d04f7", name: "Сыры",
                categImageUrl: "syry",
                subcategories: [
                    Subcategory(subcategoryID: "0bf9c7d9-36b7-11ee-ab45-d8bbc19d04f7", name: "Сыры")
                ]
            ),
            Category(
                categoryID: "", name: "Хлеб и выпечка",
                categImageUrl: "hleb-i-vypechka",
                subcategories: [
                    Subcategory(subcategoryID: "", name: "Выпечка и пироги"),
                    Subcategory(subcategoryID: "", name: "Хлебцы, сухарики, крекеры")
                ]
            ),
            Category(
                categoryID: "fc7a5db4-3681-11ee-ab45-d8bbc19d04f7", name: "Чай, кофе, какао",
                categImageUrl: "kofe-chaj-kakao",
                subcategories: [
                    Subcategory(subcategoryID: "fa64ab4d-367f-11ee-ab45-d8bbc19d04f7", name: "Чай, кофе, какао")
                ]
            ),
        ]
    }
    
    // MARK: Получение подкатегорий по выбранной категории
        func getSubcategories(for category: Category) -> [Subcategory] {
            return category.subcategories
        }
    
    // MARK: Города и адреса
    @Published var selectedCity: City? = nil
    @Published var selectedAddress: Store? = nil
    @Published var cities: [City] = [
        City(name: "Астана", stores: [
            Store(address: "Улица Алихан Бокейхан, 32"),
            Store(address: "Улица Достык, 1"),
            Store(address: "Амангельды Иманова улица, 18Б")
        ]),
        City(name: "Алматы", stores: [
            Store(address: "2-й микрорайон, 55Б"),
            Store(address: "Улица Радостовца, 323а к9"),
            Store(address: "Улица Навои, 310"),
            Store(address: "Проспект Достык, 36")
        ]),
        City(name: "Тараз", stores: [
            Store(address: "Проспект Абая, 132")
        ]),
        City(name: "Шымкент", stores: [
            Store(address: "​Улица Казыбек Би, 30"),
            Store(address: "​17-й микрорайон, 16"),
            Store(address: "​Проспект Момышулы, 8а")
        ])
    ]
    
    @Published var isPresentedHomeView: Bool = false
    @Published var isStoreSelected: Bool = false
    @Published var isShowingCatalog: Bool = false
    @Published var isShowingCategory: Bool = false
    @Published var isShowingDetail = false
    @Published var isShowingCatalogProduct = false
    @Published var isShowingFavouriteProduct = false
    @Published var isShowingProfile = false
    @Published var isShowingMain = false
    
    @Published var selectedProduct: Product?
    
}


