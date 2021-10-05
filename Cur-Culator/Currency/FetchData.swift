//
//  FetchData.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import SwiftUI

class FetchData: ObservableObject {
	
	@Published var currencyCode: [String] = []
	@Published var values : [Double] = []
	@AppStorage("code") var code = "USD"
	
	init() {
		
		fetch { (currency) in
			switch currency {
				case .success(let prices):
					DispatchQueue.main.async {
	
						self.currencyCode.append(contentsOf: prices.conversion_rates.keys)
						self.values.append(contentsOf: prices.conversion_rates.values)
						print("init")
						
					}
				case .failure(let errror):
					print("Failed to fetch currency data", errror)
			}
		}
	}
	
	func update() {
		guard let url = URL(string: "https://v6.exchangerate-api.com/v6/afe6e887229062c4a05600d4/latest/" + code ) else {
			return
		}
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				
				return
			}
			guard let JSONData = data else {
				return
			}
			
			do{
				let conversion = try JSONDecoder().decode((Currency.self), from: JSONData)
				
				DispatchQueue.main.async {
					self.currencyCode = []
					self.values = []
					self.currencyCode.append(contentsOf: conversion.conversion_rates.keys)
					self.values.append(contentsOf: conversion.conversion_rates.values)
					print("updated")
					
				}
				
			}
			catch{
				
			}
		}.resume()
	}
	
	
	
	
	
	
	
	func fetch(completion: @escaping (Result<Currency, Error>) -> ()) {
		
		guard let url = URL(string: "https://v6.exchangerate-api.com/v6/afe6e887229062c4a05600d4/latest/" + code ) else {
			return
		}
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			guard let JSONData = data else {
				return
			}
		
			do{
				let conversion = try JSONDecoder().decode((Currency.self), from: JSONData)
				
				completion(.success(conversion))
				
			}
			catch{
				completion(.failure(error))
			}
		}.resume()
	}
	
	
}


