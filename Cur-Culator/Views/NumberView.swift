//
//  NumberView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI



struct NumberView: View {
	let number: Double
	@State var isActive: Bool = false
	@Binding var state: CalculationState
	
	var numberString: String {
		if number == .pi {
			return "π"
		}
		
		return String(Int(number))
	}
	
	var body: some View {
		
		Button(action: {
			self.state.appendNumber(self.number)
			let impactMed = UIImpactFeedbackGenerator(style: .medium)
			impactMed.impactOccurred()
		}, label: {
			Text(numberString)
				.font(.title)
				.fontWeight(.bold)
				.foregroundColor(.white)
                .frame(width: self.number == 0 ? 158 : 64, height: 64)
				.background(Color.blue)
				.cornerRadius(20)
				//.shadow(color: Color.blue, radius: 10, x: 5, y: 5)
				.animation(.easeIn(duration: 0.1))
		})
	}
}
