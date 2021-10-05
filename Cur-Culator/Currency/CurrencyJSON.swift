//
//  CurrencyJSON.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 4/10/21.
//

import SwiftUI

struct CurrencyFile: Codable, Identifiable, Hashable {
	enum CodingKeys: CodingKey {
		case code
		case name
		case country
	}
	
	var id = UUID()
	var code: String
	var name: String
	var country: String
}

class ReadData: ObservableObject  {
	@Published var file = [CurrencyFile]()
	@Published var codes = [String]()
	@Published var names = [String]()
	
	init(){
		loadData()
	}
	
	func loadData()  {
		guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
		else {
			print("Json file not found")
			return
		}
		
		let data = try? Data(contentsOf: url)
		let currencies = try? JSONDecoder().decode([CurrencyFile].self, from: data!)
		self.file = currencies!
		for currency in currencies! {
			self.codes.append(currency.code)
			self.names.append(currency.name)
		}
		
	}
	
}
