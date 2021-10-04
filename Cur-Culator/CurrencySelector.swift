//
//  CountrySelector.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 5/10/21.
//
import SwiftUI


struct CurrencySelector: View {
	
	@ObservedObject var datas = ReadData()
	@State private var selection = "EUR"
		
	var body: some View {
		VStack {
			Text("Currency")
			HStack{
				Picker("\(selection)", selection: $selection) {
					ForEach(datas.file, id: \.code){ user in
						
						HStack(alignment: .firstTextBaseline, spacing: 10){
							
							Text(user.code)
								.font(.title3)
								.fontWeight(.heavy)
								.foregroundColor(Color.gray)
						}
					}
					Image(systemName: "arrowtriangle.down")
				}
				.pickerStyle(MenuPickerStyle())
			}
		}
	}
}
