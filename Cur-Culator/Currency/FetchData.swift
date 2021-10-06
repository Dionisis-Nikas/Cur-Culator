//
//  FetchData.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import SwiftUI

class FetchData: ObservableObject {
	
	@Published var currencyCode: [String] = []
	@Published var baseFlagURL: String = ""
	@Published var targetFlagURL: String = ""
	@Published var values : [Double] = []
	@AppStorage("code") var code = "USD"
	@AppStorage("convert") var currencySelection = "USD"
	
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
		
		fetchFlag(flagCode: code) { (flag) in
			switch flag {
				case .success(let urls):
					DispatchQueue.main.async {
						self.baseFlagURL = urls
						print("init flag")
					}
				case .failure(let errror):
					print("Failed to fetch currency data", errror)
			}
		}
		
		fetchFlag(flagCode: currencySelection) { (flag) in
			switch flag {
				case .success(let urls):
					DispatchQueue.main.async {
						self.targetFlagURL = urls
						print("init flag")
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
	
	func updateFlags(baseCode: String, targetCode: String) {
		guard let url = URL(string: "https://v6.exchangerate-api.com/v6/afe6e887229062c4a05600d4/enriched/" + code + "/" + baseCode ) else {
			return
		}
		guard let url2 = URL(string: "https://v6.exchangerate-api.com/v6/afe6e887229062c4a05600d4/enriched/" + code + "/" + targetCode ) else {
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
				let flags = try JSONDecoder().decode((FlagData.self), from: JSONData)
				
				DispatchQueue.main.async {
					self.baseFlagURL = flags.target_data["flag_url"] ?? "Not found"
					print("updated")
					
				}
				
			}
			catch{
				
			}
		}.resume()
		
		URLSession.shared.dataTask(with: url2) { (data, response, error) in
			if let error = error {
				
				return
			}
			guard let JSONData = data else {
				return
			}
			
			do{
				let flags = try JSONDecoder().decode((FlagData.self), from: JSONData)
				
				DispatchQueue.main.async {
					self.targetFlagURL = flags.target_data["flag_url"] ?? "Not found"
					
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
	
	func fetchFlag(flagCode: String, completion: @escaping (Result<String, Error>) -> ()) {
		
		guard let url = URL(string: "https://v6.exchangerate-api.com/v6/afe6e887229062c4a05600d4/enriched/" + code + "/" + flagCode) else {
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
				let flag_data = try JSONDecoder().decode((FlagData.self), from: JSONData)
				completion(.success(flag_data.target_data["flag_url"] ?? "Not found"))
				
			}
			catch{
				completion(.failure(error))
			}
		}.resume()
	}
}


