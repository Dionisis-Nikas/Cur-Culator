//
//  Filter.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 5/10/21.
//

import SwiftUI

struct Filter: View {
	
	@State var codes: [String]
	@State var names: [String]
	@State private var pickerSelection: String = ""
	@State private var searchTerm: String = ""
	@AppStorage("code") private var code = "USD"
	
	var filteredCurrencies: [String] {
		codes.filter {
			searchTerm.isEmpty ? true : $0.lowercased().contains(searchTerm.lowercased())
		}
	}
	
	var body: some View {

		SearchBar(text: $searchTerm)
		ForEach(filteredCurrencies, id: \.self) { user in
			
				HStack(alignment: .center, spacing: 10){
					
					Text(user)
						.font(.title)
						.fontWeight(.heavy)
						.foregroundColor(Color.white)
						
				}
				.padding(10)
			}
		}
}
