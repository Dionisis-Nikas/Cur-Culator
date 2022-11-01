//
//  CalculationState.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 5/10/21.
//

import SwiftUI


class CalculationState: ObservableObject {
	@Published var currentNumber: Double = 0
    @Published var decimal: Bool = false
    @Published var edit: Bool = true
    @Published var level = 1
    @Published var start: Bool = true
	@Published var displayString = "0"
    @Published var storedNumber: Double? = 0.0
    @Published var storedAction: ActionView.Action?
	
	
    func toogleStart() {
        self.start.toggle()
    }

    func appendNumber(_ number: Double) {
		
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

		} else {
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
        } else{
            currentNumber = number
            edit = true
            }
        }
        self.setDisplayString()
	}

    func setDisplayString() {
        let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 5
        let currentNumber = self.currentNumber
        var intNumber = 0
        if !currentNumber.isNaN && !currentNumber.isInfinite {
            intNumber = Int(currentNumber)
        } else if currentNumber.isInfinite {
            displayString = String(currentNumber)
        } else {
            displayString = "NaN"
        }
        let result = currentNumber / Double(intNumber)
        let currentCount = String(result - 1.0).count
        displayString = self.currentNumber.truncatingRemainder(dividingBy: 1) == 0 || self.decimal && self.level != (currentCount - 2) ?

        String(format: (self.decimal && self.edit ? "%." + String(self.level - 1) + "f" : "%.0f"), arguments: [self.currentNumber])

        :

        formatter.string(from: NSNumber(value: self.currentNumber)) ?? "NaN"
    }
}

