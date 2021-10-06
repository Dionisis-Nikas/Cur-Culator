//
//  CommaButtonView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI

struct CommaButtonView: View {

	@Binding var state: CalculationState

	var body: some View {
		
		Button(action: {
			self.state.decimal = true
			self.state.after = true
			let impactMed = UIImpactFeedbackGenerator(style: .medium)
			impactMed.impactOccurred()
		}, label: {
			Text(",")
				.font(.title)
				.fontWeight(.bold)
				.foregroundColor(.white)
				.frame(width: 64, height: 64)
				.background(self.state.decimal ? Color.gray : Color.blue)
				.cornerRadius(20)
				//.shadow(color: Color.blue, radius: 10, x: 5, y: 5)
				.animation(.easeIn(duration: 0.1))
		})
	}
}
