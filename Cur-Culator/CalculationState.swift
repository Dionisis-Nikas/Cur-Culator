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
	var edit: Bool = true
	var level = 1
	
	var storedNumber: Double?
	var storedAction: ActionView.Action?
	
	
	
	mutating func appendNumber(_ number: Double) {
		
		if (currentNumber.truncatingRemainder(dividingBy: 1) == 0) && decimal == false {
			if edit {
				if currentNumber >= 0 {
					currentNumber = (currentNumber * 10) + number
				}
				else{
					currentNumber = (currentNumber * 10) - number
				}
			}
			else {
				currentNumber = number
				edit = true
			}
		}
		
		else{
			if edit {
				
				
				if currentNumber >= 0 {
					currentNumber = currentNumber  + (number / ((pow(10, Double(level)))))
				}
				else{
					currentNumber = currentNumber  - (number / ((pow(10, Double(level)))))
				}
				level += 1
			}
			else{
				currentNumber = number
				edit = true
			}
		}
			
			
		
	}
}

