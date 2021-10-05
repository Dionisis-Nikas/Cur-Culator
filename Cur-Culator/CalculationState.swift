//
//  CalculationState.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 5/10/21.
//

import SwiftUI


struct CalculationState {
	var currentNumber: Double = 0
	var decimal: Bool = false
	
	var storedNumber: Double?
	var storedAction: ActionView.Action?
	var after: Bool = false
	
	
	mutating func appendNumber(_ number: Double) {
		
		if number.truncatingRemainder(dividingBy: 1) == 0
			&& currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
			if decimal {
				let level = String(Int(currentNumber)).count
				currentNumber = currentNumber  + number / ((pow(10, Double(level))))
				
			}
			else {
				if after {
					currentNumber = 0 + number
					after = false
				}
				else {
					currentNumber = 10 * currentNumber + number
				}
			}
		}
		else {
			if (decimal) {
				let level = String(Double(currentNumber)).count - 1
				currentNumber = currentNumber  + number / ((pow(10, Double(level))))
			}
			
			
		}
	}
}

