//
//  Conversion.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import SwiftUI

//for fetching
struct Conversion: Decodable {
    
	var results : [String: Symbol]
}

struct Symbol: Decodable {
	
	var currencyName: String
	var currencySymbol: String
	var id: String
}
