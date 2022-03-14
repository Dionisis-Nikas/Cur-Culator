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
                let stringNumber = String(Int(currentNumber))
                if stringNumber.count <= 9 {
                    if currentNumber >= 0 {
                        currentNumber = (currentNumber * 10) + number
                    }
                    else{
                        currentNumber = (currentNumber * 10) - number
                    }
                }
            }
            else {
                currentNumber = number
                edit = true
            }

		}
		
		else{
            if edit {
                var stringNumber = String(currentNumber)
                let formatter = NumberFormatter()
                    formatter.minimumFractionDigits = 0
                    formatter.maximumFractionDigits = 5
                formatter.decimalSeparator = "."
                if stringNumber.count <= 11 && level <= 5 {
                    if currentNumber >= 0 {
                        currentNumber = currentNumber  + (number / ((pow(10, Double(level)))))
                    }
                    else{
                        currentNumber = currentNumber  - (number / ((pow(10, Double(level)))))
                    }

                    stringNumber = formatter.string(from: NSNumber(value: currentNumber)) ?? "NaN"
                    currentNumber = Double(stringNumber) ?? .nan
                    level += 1
                }
            }
            else{
                currentNumber = number
                edit = true
            }

		}
			
			
		
	}
}

