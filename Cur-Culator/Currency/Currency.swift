//
//  Currency.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 2/10/21.
//

import SwiftUI

//for displaying data
struct Currency : Identifiable {
	
	var id = UUID().uuidString
	var currencyName : String
	var currencyValue : Double
}
