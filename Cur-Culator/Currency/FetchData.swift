//
//  FetchData.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import SwiftUI

class FetchData: ObservableObject {
    
	@Published var conversionData : [Currency] = []
	
	init() {
		fetch()
	}
	
	func fetch() {
		
		let url = "https://free.currconv.com/api/v7/currencies?apiKey=91b848944cdf57506ec9"
		
		let session = URLSession(configuration: .default)
		
		session.dataTask(with: URL(string: url)!) { (data, _, _) in
		guard let JSONData = data else {
			return
		}
		
		do{
			let conversion = try JSONDecoder().decode((Conversion.self), from: JSONData)
			
			print(conversion)
			}
		catch{
			print(error.localizedDescription)
		}
		}.resume()
	}
}

