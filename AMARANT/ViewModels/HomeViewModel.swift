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
                name: "Бакалея",
                categImageUrl: "bakaleya",
                subcategories: [
                    Subcategory(name: "Заменитель сахара"),
                    Subcategory(name: "Ингредиенты для выпечки"),
                    Subcategory(name: "Сахар, соль, специи")
                ]
            ),
            Category(
                name: "Бытовая химия",
                categImageUrl: "bytovaya-himiya",
                subcategories: [
                    Subcategory(name: "Бытовая химия и товары для дома"),
                    Subcategory(name: "Средства для стирки")
                ]
            ),
            Category(
                name: "Веганское, растительное",
                categImageUrl: "veganskie-tovary",
                subcategories: [
                    Subcategory(name: "Вместо молока"),
                    Subcategory(name: "Паштеты"),
                    Subcategory(name: "Растительный белок")
                ]
            ),
            Category(
                name: "Завтраки",
                categImageUrl: "breakfast",
                subcategories: [
                    Subcategory(name: "Отруби, семена и клетчатка"),
                    Subcategory(name: "Сухие завтраки, хлопья, мюсли")
                ]
            ),
            Category(
                name: "Замороженные продукты",
                categImageUrl: "zamorozhennye-produkty",
                subcategories: [
                    Subcategory(name: "Замороженные фрукты, овощи, грибы"),
                    Subcategory(name: "Мясная продукция"),
                    Subcategory(name: "Пельмени, манты, вареники, выпечка")
                ]
            ),
            Category(
                name: "Здоровье",
                categImageUrl: "zdorove",
                subcategories: [
                    Subcategory(name: "Витамины, БАД"),
                    Subcategory(name: "Для детей"),
                    Subcategory(name: "Спортивное питание"),
                    Subcategory(name: "Фитосвечи")
                ]
            ),
            Category(
                name: "Консервация",
                categImageUrl: "konservaciya",
                subcategories: [
                    Subcategory(name: "Варенье и джемы"),
                    Subcategory(name: "Оливки и маслины"),
                    Subcategory(name: "Паштеты и тушенка"),
                    Subcategory(name: "Рыбные консервы"),
                    Subcategory(name: "Томатные пасты"),
                    Subcategory(name: "Уксус"),
                    Subcategory(name: "Фрукты, овощи, морские водоросли")
                ]
            ),
            Category(
                name: "Красота и гигиена",
                categImageUrl: "krasota-i-zdorove",
                subcategories: [
                    Subcategory(name: "Бомбочки, пена и соль для ванн"),
                    Subcategory(name: "Гели для душа"),
                    Subcategory(name: "Косметика и уход"),
                    Subcategory(name: "Мочалки, щетки, пилки")
                ]
            ),
            Category(
                name: "Крупы, макароны, мука",
                categImageUrl: "krupy-makarony-krupa",
                subcategories: [
                    Subcategory(name: "Каши"),
                    Subcategory(name: "Крупы"),
                    Subcategory(name: "Макароны"),
                    Subcategory(name: "Мука"),
                    Subcategory(name: "Супы")
                ]
            ),
            Category(
                name: "Масла и соусы",
                categImageUrl: "maslo-sousy",
                subcategories: [
                    Subcategory(name: "Масло ГХИ и сливочное"),
                    Subcategory(name: "Растительные масла"),
                    Subcategory(name: "СОУСЫ")
                ]
            ),
            Category(
                name: "Молочные продукты и яйцо",
                categImageUrl: "molochnye-produkty-i-yajco",
                subcategories: [
                    Subcategory(name: "Из козьего, кобыльего и овечьего молока"),
                    Subcategory(name: "Молоко, кефир, йогурт")
                ]
            ),
            Category(
                name: "Мороженое",
                categImageUrl: "morozhennoe",
                subcategories: [
                    Subcategory(name: "Мороженое")
                ]
            ),
            Category(
                name: "Напитки и детское питание",
                categImageUrl: "napitki",
                subcategories: [
                    Subcategory(name: "Детское питание и смеси"),
                    Subcategory(name: "Комбуча"),
                    Subcategory(name: "Компоты и кисели"),
                    Subcategory(name: "Минеральная вода"),
                    Subcategory(name: "Соки, смузи")

                ]
            ),
            Category(
                name: "Орехи, чипсы и снеки",
                categImageUrl: "orekhi-chipsy-sneki",
                subcategories: [
                    Subcategory(name: "Орехи"),
                    Subcategory(name: "Попкорн"),
                    Subcategory(name: "Снеки"),
                    Subcategory(name: "Сухофрукты"),
                    Subcategory(name: "Чипсы")
                ]
            ),
            Category(
                name: "Пасты и Урбечи",
                categImageUrl: "urbechi",
                subcategories: [
                    Subcategory(name: "Пасты и Урбечи")
                ]
            ),
            Category(
                name: "Сладости и здоровые десерты",
                categImageUrl: "sladosti-i-zdorovye-deserty",
                subcategories: [
                    Subcategory(name: "Вафли и пряники"),
                    Subcategory(name: "Конфеты и карамель"),
                    Subcategory(name: "Мармелад, зефир, пастила"),
                    Subcategory(name: "Мед, сиропы и сгущенка"),
                    Subcategory(name: "Печенье"),
                    Subcategory(name: "Пирожные и десерты"),
                    Subcategory(name: "Чурчхела"),
                    Subcategory(name: "Шоколад и батончики")
                ]
            ),
            Category(
                name: "Сыры",
                categImageUrl: "syry",
                subcategories: [
                    Subcategory(name: "Сыры")
                ]
            ),
            Category(
                name: "Хлеб и выпечка",
                categImageUrl: "hleb-i-vypechka",
                subcategories: [
                    Subcategory(name: "Выпечка и пироги"),
                    Subcategory(name: "Хлебцы, сухарики, крекеры")
                ]
            ),
            Category(
                name: "Чай, кофе, какао",
                categImageUrl: "kofe-chaj-kakao",
                subcategories: [
                    Subcategory(name: "Чай, кофе, какао")
                ]
            )
        ]
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


    @Published var selectedProduct: Product?

}


