//
//  Currency.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import Foundation


struct Currency : Codable {
	
	let conversion_rates: [String: Double]
	
	init(values: [String: Double]){
		self.conversion_rates = values
	}
}
