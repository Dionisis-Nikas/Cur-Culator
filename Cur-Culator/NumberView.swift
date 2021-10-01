//
//  NumberView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI

struct NumberView: View {
	let number: Double
	@Binding var state: CalculationState
	
	var numberString: String {
		if number == .pi {
			return "π"
		}
		return String(Int(number))
	}
	
	var body: some View {
		Text(numberString)
			.font(.title)
			.fontWeight(.bold)
			.foregroundColor(.white)
			.frame(width: 64, height: 64)
			.background(Color.blue)
			.cornerRadius(20)
			.shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
			.onTapGesture {
				self.state.appendNumber(self.number)
			}
	}
}
