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
	var pre = 0
	
	
	mutating func appendNumber(_ number: Double) {
		
		if number.truncatingRemainder(dividingBy: 1) == 0
			&& currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
			if decimal {
				if after {
					if currentNumber >= 0 {
						if number != 0 {
							pre = 0
							let level = String(Int(currentNumber)).count
							currentNumber = currentNumber  + number / ((pow(10, Double(level))))
						}
						else {
							pre += 1
						}
					}
					else {
						pre = 0
						let level = String(Int((-1) * currentNumber)).count
						currentNumber = currentNumber  - number / ((pow(10, Double(level))))
					}
					self.after = false
				}
				else {
					if number == 0 {
						pre += 1
					}
					else{
						if pre > 0 {
							currentNumber = currentNumber  + (number / (pow(10, Double(pre+1))))
							pre = 0
						}
						else {
							currentNumber = number
							after = false
						}
						
					}
				}
				
			}
			else {
				if after {
					currentNumber = 0 + number
					after = false
				}
				else {
					if currentNumber < 0 {
						currentNumber = 10 * currentNumber - number
					}
					else {
						currentNumber = 10 * currentNumber + number
					}
				}
			}
		}
		else {
			if (currentNumber.truncatingRemainder(dividingBy: 1) != 0) || (number == 0) {
				if after {
					currentNumber = 0 + number
				}
				else {
					if currentNumber >= 0 {
						if number == 0{
							pre += 1
						}
						else {
							let level = String(Double(currentNumber)).count - 1
							currentNumber = currentNumber  + number / ((pow(10, Double(level))))
						}
					}
					else {
						if number == 0{
							pre += 1
						}
						else {
							let level = String(Double((-1) * currentNumber)).count - 1
							currentNumber = currentNumber  - number / ((pow(10, Double(level))))
						}
					}
				}
			}
			
			
		}
	}
}

