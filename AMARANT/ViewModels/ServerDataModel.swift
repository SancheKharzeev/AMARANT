//
//  ServerDataModel.swift
//  AMARANT
//
//  Created by Александр Х on 29.08.2024.
//

import Foundation
import SwiftUI
import Combine

class ServerDataModel: NSObject, ObservableObject {
    @Published var catalogProducts: [Product] = []
    @Published var popularProducts: [Product] = []
    @Published var progress: Double = 0.0 // Прогресс загрузки
    
    
    // Simulate loading data
    override init() {
        super.init()
//        fetchProductsFromServer()
//        loadCatalogProducts()
        loadPopularProducts()
        loadProductsFromFile()

    }
    
    
    func loadProductsFromFile() {
        if let url = Bundle.main.url(forResource: "products", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                if let products = decodeProducts(from: data) {
                    self.catalogProducts = products
                }
            } catch {
                print("Ошибка чтения файла JSON: \(error)")
            }
        } else {
            print("Файл JSON не найден")
        }
    }
    
    func decodeProducts(from data: Data) -> [Product]? {
        let decoder = JSONDecoder()
        
        do {
            let productDict = try decoder.decode([String: ProductResponse].self, from: data)
            let products = productDict.values.map { response -> Product in
                return Product(
                    name: response.name,
                    description: response.description.isEmpty ? "Нет описания" : response.description,
                    price: Double(round(100 * response.price) / 100),
                    imageUrl: "amarantsoda", // Placeholder или реальные изображения
                    subCategoryName: response.subCategoryName,
                    subCategoryID: response.subCategoryID,
                    imagesOfProduct: [detailProduct(imageUrl: "amarantsoda"), detailProduct(imageUrl: "maslo-sousy"), detailProduct(imageUrl: "molochnye-produkty-i-yajco")],
                    articul: response.artiсul,
                    count: response.count,
                    storageName: response.storageName,
                    storageID: response.storageID
                )
            }
            return products
        } catch {
            print("Ошибка декодирования: \(error)")
            return nil
        }
    }
    

    
    
    
    // MARK: Симуляция популярных товаров
    func loadPopularProducts() {
        popularProducts = [
            createProduct(name: "AMARANT Сода пищевая 500 гр.",
                          description: "Пищевая сода (бикарбонат натрия) Страна производства Турция. Это натуральная пищевая сода без добавок \n- Снижает уровень кислотности в организме \n- Восстанавливает Ph баланс, справляется с изжогой",
                          price: 2710,
                          imageUrl: "amarantsoda",
                          subCategoryName: "Ингредиенты для выпечки", articul: "00000000443120"),
            createProduct(name: "R.A.W. LIFE Гранола протеиновая Кофе и Инжир 220 г",
                          description: "Состав Хлопья овсяные без содержания глютена, концентрированный сок винограда, миндаль, кокосовое масло, изюм, смесь протеинов (гороховый белок, белок из семян чиа), взорванное зерно гречихи, инжир, кофе зерновой, корица, кардамон, соль розовая гималайская, витамин Е (смесь токоферолов).",
                          price: 1620,
                          imageUrl: "rawlife",
                          subCategoryName: "Сухие завтраки, хлопья, мюсли", articul: "000000001120"),
            createProduct(name: "REFOOD Дрожжи пищевые неактивные в хлопьях PREMIUM 100 гр.",
                          description: "REFOOD Дрожжи пищевые неактивные в хлопьях PREMIUM 100 гр.",
                          price: 1990,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/f7/f70b3ed84adb11edaf5b0026182c78e3_11eba0d0a08711eeab48d8bbc19d04f7-220x220.jpeg",
                          subCategoryName: "Ингредиенты для выпечки", articul: "000000001119"),
            createProduct(name: "Lunn Чёрная соль 200 гр.",
                          description: "Lunn Чёрная соль 200 гр.",
                          price: 990,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/14/146282550d1e11efab51d8bbc19d04f7_f347f4bb229a11efab51d8bbc19d04f7-220x220.jpeg",
                          subCategoryName: "Заменитель сахара", articul: "000000001118"),
            createProduct(name: "Fit Parad №8 Заменитель сахара на основе",
                          description: "Fit Parad №8 Заменитель сахара на основе",
                          price: 1490,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/9f/9f7c5157257c11e793fd001966967e40_23cf3d4ba08511eeab48d8bbc19d04f7-220x220.jpg",
                          subCategoryName: "Заменитель сахара", articul: "000000001117"),
            createProduct(name: "Apple",
                          description: "Fresh apple",
                          price: 1990,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/f7/f70b3ed84adb11edaf5b0026182c78e3_11eba0d0a08711eeab48d8bbc19d04f7-220x220.jpeg",
                          subCategoryName: "Заменитель сахара", articul: "000000001116"),
            createProduct(name: "Banana",
                          description: "Fresh banana",
                          price: 990,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/14/146282550d1e11efab51d8bbc19d04f7_f347f4bb229a11efab51d8bbc19d04f7-220x220.jpeg",
                          subCategoryName: "Заменитель сахара", articul: "000000001115"),
            createProduct(name: "Acvelon Genius Kids 30 мл. (для нервной системы)",
                          description: "Fresh orange",
                          price: 1490,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/c2/c2325b39ba8011eeab49d8bbc19d04f7_8f8e3d3ec66d11eeab4ad8bbc19d04f7-220x220.png",
                          subCategoryName: "Заменитель сахара", articul: "000000001114"),
            createProduct(name: "A BIO Витамин В9 30 мл",
                          description: "A BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 мл",
                          price: 2360,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/1a/1a0b1158959111eeab47d8bbc19d04f7_ab656f7bbf2e11eeab4ad8bbc19d04f7-220x220.png",
                          subCategoryName: "Заменитель сахара", articul: "000000001113"),
            createProduct(name: "4Life Трансфер Фактор РиоВида Берст (15 саше)",
                          description: "СОСТАВ: вода, сок яблочный, сок винограда фиолетового, глицерин растительный, сок черничный, 4Life Трай-Фактор формула (коровье молозиво и куриный желток) — 600 мг/пакет, сок гранатовый, ксантановая камедь (желеобразователь), гуаровая камедь (желеобразователь), концентрат сока виноградного, сок бузины черной, ароматизатор ягодно-сливочный (пропиленгликоль, вода, глицерин, спирт, вкусоароматические натуральные вещества, краситель карамельный) порошок асаи, аскорбиновая кислота (витамин С), монолаурат глицерина (лауриновая кислота). Поддержка иммунной системы и антиоксидантная поддержка в форме освежающего желе* Широкий спектр поддержки иммунной системы* Содержит 4Life Трансфер Фактор, который способен повышать активность клеток-киллеров до 283%*+ С биофлавоноидами, которые способствуют антиоксидантной защите организма* Что такое 4Life РиоВида Бёрст™ Трай-Фактор™ формула? РиоВида Бёрст — это активная поддержка иммунной системы в форме нежного и приятного на вкус желе. Бодрящая антиоксидантная смесь асаи, граната, черники, бузины и винограда содержит сертифицированный 4Life Трансфер Фактор, который помогает вашей иммунной системе распознавать, запоминать и реагировать на потенциальные угрозы организму.* Ключевые положения: Первый и единственный желеобразный продукт с содержанием 4Life Трансфер Фактора® Трай-Фактора™ Содержит 4Life Трансфер Фактор для повышения I.Q. иммунной системы. Трансфер — факторы «обучают» иммунные клетки распознавать, запоминать и отвечать на потенциальные угрозы организму* Вкусный и удобный в использовании источник необходимых организму витаминов, минералов, аминокислот, жирных кислот и полифенолов* Содержит антиоксиданты, которые помогают защитить организм от естественных свободных радикалов* Способствует здоровому функционированию иммунной системы, что, в свою очередь, способствует вашей энергичности и здоровому функционированию всех других систем организма* Защищен патентами США: 6 468 534 (процесс экстракции трансфер-факторов из яичных источников), 6 866 868 (комбинирование трансфер-факторов из коровьего молозива и желтков куриных яиц) и 9 028 882 (трансфер-факторы в съедобном желе) Упакован в пакетики из фольги, которые легко носить в сумке и делиться с друзьями",
                          price: 23490,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/7d/7d0f8edcb55411eeab49d8bbc19d04f7_8e58ec0c23d711efab51d8bbc19d04f7-220x220.jpeg",
                          subCategoryName: "Заменитель сахара", articul: "000000001112"),
        ]
    }
    
    func createProduct(name: String, description: String, price: Double, imageUrl: String, subCategoryName: String, articul: String) -> Product {
        //карусель фотографий описания товара
        let detailImages = Array(arrayLiteral: detailProduct(imageUrl: imageUrl), detailProduct(imageUrl: imageUrl), detailProduct(imageUrl: imageUrl), detailProduct(imageUrl: imageUrl))
        //возвращаем вместе с остальным описанием товара
        return Product(name: name, description: description, price: price, imageUrl: imageUrl, subCategoryName: subCategoryName, subCategoryID: "1111-2222-3333-4444", imagesOfProduct: detailImages, articul: articul, count: 10, storageName: "AMARANT (ИП Собиров)", storageID: "c81a1383-1359-11e9-baac-0026182c77c8")
    }
    
    /*
    // MARK: Асинхронная функция для получения продуктов с сервера
    func fetchProductsFromServer() {
        guard let url = URL(string: "https://2.135.218.2/ut_api/hs/products/get_products") else {
            print("Некорректный URL")
            return
        }
        
        // Создаем сессию с делегатом для отслеживания прогресса
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        let task = session.downloadTask(with: url)
        task.resume()
    }
    
    // Метод для обработки завершенной загрузки
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // Преобразуем загруженные данные в массив продуктов
        if let data = try? Data(contentsOf: location) {
            DispatchQueue.main.async {
                if let products = self.decodeProducts(from: data) {
                    self.catalogProducts = products
                }
            }
        }
    }
    
    // Метод для обновления прогресса загрузки
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            self.progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
            print("Прогресс загрузки: \(self.progress)")
        }
    }
    
    // Функция декодирования полученных данных
    func decodeProducts(from data: Data) -> [Product]? {
        let decoder = JSONDecoder()
        
        do {
            let productDict = try decoder.decode([String: ProductResponse].self, from: data)
            let products = productDict.values.map { response -> Product in
                return Product(
                    name: response.name,
                    description: response.description.isEmpty ? "Нет описания" : response.description,
                    price: response.price,
                    imageUrl: "https://placeholder.com/image.jpg", // Placeholder или реальные изображения
                    subCategoryName: response.subCategoryName,
                    subCategoryID: response.subCategoryID,
                    imagesOfProduct: [detailProduct(imageUrl: "https://placeholder.com/image.jpg")],
                    articul: response.articul,
                    count: response.count,
                    storageName: response.storageName,
                    storageID: response.storageID
                )
            }
            return products
        } catch {
            print("Ошибка декодирования: \(error)")
            return nil
        }
    }
    
    
    
    // MARK: Симуляция каталога товаров
    func loadCatalogProducts() {
        catalogProducts = [
            createProduct(name: "AMARANT Сода пищевая 500 гр.",
                          description: "Пищевая сода (бикарбонат натрия) Страна производства Турция. Это натуральная пищевая сода без добавок \n- Снижает уровень кислотности в организме \n- Восстанавливает Ph баланс, справляется с изжогой",
                          price: 2710,
                          imageUrl: "amarantsoda",
                          subCategoryName: "Ингредиенты для выпечки", articul: "000000004431420"),
            createProduct(name: "Настин Сластин Панкейки высокобелковые 1000гр.",
                          description: "Состав \nмука рисовая 24%, гороховый протеин 21%, мука из зеленой гречки 20%, кукурузный крахмал 17%, пудра кокосового сахара 15%, соль гималайская розовая 1%, сода пищевая 1%, лимонная кислота 1%",
                          price: 4600,
                          imageUrl: "nastinpancake",
                          subCategoryName: "Ингредиенты для выпечки", articul: "000000003232120"),
            createProduct(name: "R.A.W. LIFE Гранола протеиновая Кофе и Инжир 220 г",
                          description: "Состав Хлопья овсяные без содержания глютена, концентрированный сок винограда, миндаль, кокосовое масло, изюм, смесь протеинов (гороховый белок, белок из семян чиа), взорванное зерно гречихи, инжир, кофе зерновой, корица, кардамон, соль розовая гималайская, витамин Е (смесь токоферолов).",
                          price: 1620,
                          imageUrl: "rawlife",
                          subCategoryName: "Заменитель сахара", articul: "0000000011220"),
            createProduct(name: "R.A.W. LIFE Гранола протеиновая Кофе и Инжир 220 г",
                          description: "Состав Хлопья овсяные без содержания глютена, концентрированный сок винограда, миндаль, кокосовое масло, изюм, смесь протеинов (гороховый белок, белок из семян чиа), взорванное зерно гречихи, инжир, кофе зерновой, корица, кардамон, соль розовая гималайская, витамин Е (смесь токоферолов).",
                          price: 1620,
                          imageUrl: "rawlife",
                          subCategoryName: "Ингредиенты для выпечки", articul: "0000000014120"),
            
            createProduct(name: "R.A.W. LIFE Гранола протеиновая Кофе и Инжир 220 г",
                          description: "Состав Хлопья овсяные без содержания глютена, концентрированный сок винограда, миндаль, кокосовое масло, изюм, смесь протеинов (гороховый белок, белок из семян чиа), взорванное зерно гречихи, инжир, кофе зерновой, корица, кардамон, соль розовая гималайская, витамин Е (смесь токоферолов).",
                          price: 1620,
                          imageUrl: "rawlife",
                          subCategoryName: "Сухие завтраки, хлопья, мюсли", articul: "0000000011220"),
            
            createProduct(name: "REFOOD Дрожжи пищевые неактивные в хлопьях PREMIUM 100 гр.",
                          description: "REFOOD Дрожжи пищевые неактивные в хлопьях PREMIUM 100 гр.",
                          price: 1990,
                          imageUrl: "batonchik1",
                          subCategoryName: "Ингредиенты для выпечки", articul: "00000000113319"),
            
            createProduct(name: "svetinorm",
                          description: "Lunn Чёрная соль 200 гр. Lunn Чёрная соль 200 гр. Lunn Чёрная соль 200 гр. Lunn Чёрная соль 200 гр.",
                          price: 990,
                          imageUrl: "svetinorm",
                          subCategoryName: "Сахар, соль, специи", articul: "000000001118"),
            
            createProduct(name: "Lunn Чёрная соль 200 гр.",
                          description: "Lunn Чёрная соль 200 гр.",
                          price: 990,
                          imageUrl: "batonchik2",
                          subCategoryName: "Бытовая химия и товары для дома", articul: "0000000011158"),
            
            createProduct(name: "Lunn Чёрная соль 200 гр.",
                          description: "Lunn Чёрная соль 200 гр.",
                          price: 990,
                          imageUrl: "batonchik2",
                          subCategoryName: "Средства для стирки", articul: "0007889918"),
            
            createProduct(name: "Fit Parad №8 Заменитель сахара на основе",
                          description: "Fit Parad №8 Заменитель сахара на основе",
                          price: 1490,
                          imageUrl: "batonchik3",
                          subCategoryName: "Вместо молока", articul: "00786601117"),
            
            createProduct(name: "Stamakort",
                          description: "Fresh apple",
                          price: 1990,
                          imageUrl: "stamakort",
                          subCategoryName: "Паштеты", articul: "00089701116"),
            
            createProduct(name: "Suprefort",
                          description: "Fresh banana",
                          price: 990,
                          imageUrl: "suprefort",
                          subCategoryName: "Растительный белок", articul: "000768001115"),
            
            createProduct(name: "Acvelon Genius Kids 30 мл. (для нервной системы)",
                          description: "Fresh orange",
                          price: 1490,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/c2/c2325b39ba8011eeab49d8bbc19d04f7_8f8e3d3ec66d11eeab4ad8bbc19d04f7-220x220.png",
                          subCategoryName: "Отруби, семена и клетчатка", articul: "000780001114"),
            
            createProduct(name: "A BIO Витамин В9 30 мл",
                          description: "A BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 млA BIO Витамин В9 30 мл",
                          price: 2360,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/1a/1a0b1158959111eeab47d8bbc19d04f7_ab656f7bbf2e11eeab4ad8bbc19d04f7-220x220.png",
                          subCategoryName: "Сухие завтраки, хлопья, мюсли", articul: "000000067801113"),
            
            createProduct(name: "4Life Трансфер Фактор РиоВида Берст (15 саше)",
                          description: "СОСТАВ: вода, сок яблочный, сок винограда фиолетового, глицерин растительный, сок черничный, 4Life Трай-Фактор формула (коровье молозиво и куриный желток) — 600 мг/пакет, сок гранатовый, ксантановая камедь (желеобразователь), гуаровая камедь (желеобразователь), концентрат сока виноградного, сок бузины черной, ароматизатор ягодно-сливочный (пропиленгликоль, вода, глицерин, спирт, вкусоароматические натуральные вещества, краситель карамельный) порошок асаи, аскорбиновая кислота (витамин С), монолаурат глицерина (лауриновая кислота). Поддержка иммунной системы и антиоксидантная поддержка в форме освежающего желе* Широкий спектр поддержки иммунной системы* Содержит 4Life Трансфер Фактор, который способен повышать активность клеток-киллеров до 283%*+ С биофлавоноидами, которые способствуют антиоксидантной защите организма* Что такое 4Life РиоВида Бёрст™ Трай-Фактор™ формула? РиоВида Бёрст — это активная поддержка иммунной системы в форме нежного и приятного на вкус желе. Бодрящая антиоксидантная смесь асаи, граната, черники, бузины и винограда содержит сертифицированный 4Life Трансфер Фактор, который помогает вашей иммунной системе распознавать, запоминать и реагировать на потенциальные угрозы организму.* Ключевые положения: Первый и единственный желеобразный продукт с содержанием 4Life Трансфер Фактора® Трай-Фактора™ Содержит 4Life Трансфер Фактор для повышения I.Q. иммунной системы. Трансфер — факторы «обучают» иммунные клетки распознавать, запоминать и отвечать на потенциальные угрозы организму* Вкусный и удобный в использовании источник необходимых организму витаминов, минералов, аминокислот, жирных кислот и полифенолов* Содержит антиоксиданты, которые помогают защитить организм от естественных свободных радикалов* Способствует здоровому функционированию иммунной системы, что, в свою очередь, способствует вашей энергичности и здоровому функционированию всех других систем организма* Защищен патентами США: 6 468 534 (процесс экстракции трансфер-факторов из яичных источников), 6 866 868 (комбинирование трансфер-факторов из коровьего молозива и желтков куриных яиц) и 9 028 882 (трансфер-факторы в съедобном желе) Упакован в пакетики из фольги, которые легко носить в сумке и делиться с друзьями",
                          price: 23490,
                          imageUrl: "https://amarant.kz/astana/image/cache/import_files/7d/7d0f8edcb55411eeab49d8bbc19d04f7_8e58ec0c23d711efab51d8bbc19d04f7-220x220.jpeg",
                          subCategoryName: "Замороженные фрукты, овощи, грибы", articul: "00000099001112"),
        ]
    }
    */
}
