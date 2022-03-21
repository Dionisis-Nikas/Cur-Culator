//
//  Currency.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import Foundation


struct Currency : Codable {
	
	let conversion_rate: Double
    let date: String
	
    init(conversion_rate: Double, date: String){
		self.conversion_rate = conversion_rate
        self.date = date
	}
}
