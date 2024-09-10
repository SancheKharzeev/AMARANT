//
//  SelectStoreView.swift
//  AMARANT
//
//  Created by Александр Х on 08.08.2024.
//

import SwiftUI

struct SelectStoreView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Выберите адрес \nгастромаркета AMARANT")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .fontDesign(.rounded)
                    .foregroundColor(.gold)
                    .background(.productPink)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .bold()

                
                List(viewModel.cities) { city in
                    let isSelecteedCity = viewModel.selectedCity?.id == city.id
                    
                    Button(action: {
                        self.viewModel.selectedCity = city
                        viewModel.selectedAddress = nil
                    }) {
                        Text(city.name)
                            .foregroundStyle(isSelecteedCity ? .white : .black)
                            .bold()
                            .fontDesign(.rounded)
                            .font(.title2)
                    }
                    .listRowBackground(isSelecteedCity ? Color.gold : Color.clear)
                }
                
                if let selectedCity = viewModel.selectedCity {
                    List(selectedCity.stores) { store in
                        let isSelecteedAdress = viewModel.selectedAddress?.id == store.id
                        
                        Button(action: {
                            self.viewModel.selectedAddress = store
                        }) {
                            Text(store.address)
                                .foregroundStyle(isSelecteedAdress ? .white : .black)
                                .bold()
                        }
                        .listRowBackground(isSelecteedAdress ? Color.gold : Color.clear)
                    }
                    
                    // Отображение выбранного адреса
                    styledText(text: "Гастромаркет по адресу: \n\(selectedCity.name)", textColor: .black, txtSize: .headline, backColor: Color.clear.gradient)
                }
             
                if let selectedAddress = viewModel.selectedAddress {
                    styledText(text: "\(selectedAddress.address)", textColor: .black, txtSize: .body, backColor: Color.clear.gradient)
                        .padding(.bottom, 20)
                    Button(action: {
                        // action button
                        viewModel.isStoreSelected = true
                    }, label: {
                        styledText(text: "Далее", textColor: .white, txtSize: .headline, backColor: Color.productPink.gradient)
                    })
                }
            }
        }
    }
    @ViewBuilder
    func styledText(text: String, textColor: Color, txtSize: Font, backColor: AnyGradient) -> some View {
        Text(text)
            .font(txtSize)
            .multilineTextAlignment(.center)
            .padding(8)
            .foregroundColor(textColor)
            .background(backColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    SelectStoreView(viewModel: HomeViewModel())
}
