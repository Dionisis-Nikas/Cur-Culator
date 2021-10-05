//
//  CountrySelector.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 5/10/21.
//
import SwiftUI


struct CurrencySelector: View {
	
	@ObservedObject var fetchData = FetchData()
	@State var currencySelection = 0
	@State private var selection = 0
		
	var body: some View {
		VStack {
			
			HStack{
				Picker("Currency", selection: $selection) {
					ForEach(0..<fetchData.currencyCode.count){
						let currency = fetchData.currencyCode[$0]
						Text(currency)
							.font(.title3)
							.fontWeight(.heavy)
							.foregroundColor(Color.gray)
	
					}
					Image(systemName: "arrowtriangle.down")
				}
				.pickerStyle(MenuPickerStyle())
			}
		}
	}
}
