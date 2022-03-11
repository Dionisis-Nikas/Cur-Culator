//
//  CommaButtonView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI

struct CommaButtonView: View {

	@Binding var state: CalculationState

    var width: CGFloat {
        return UIScreen.main.currentMode!.size.width / 10
    }

    var height: CGFloat {
        return UIScreen.main.currentMode!.size.width / 10
    }

	var body: some View {
		
		Button(action: {
			self.state.decimal = true
			
			let impactMed = UIImpactFeedbackGenerator(style: .medium)
			impactMed.impactOccurred()
		}, label: {
			Text(",")
				.font(.largeTitle)
				.fontWeight(.bold)
				.foregroundColor(.white)
				.frame(width: width, height: height)
				.background(self.state.decimal ? Color.gray : Color.blue)
				.cornerRadius(30)
				//.shadow(color: Color.blue, radius: 10, x: 5, y: 5)
				.animation(.easeIn(duration: 0.1))
		})
	}
}
