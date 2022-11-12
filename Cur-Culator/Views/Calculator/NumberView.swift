//
//  NumberView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI



struct NumberView: View {

    @AppStorage("colorNumber") var colorNumber: Color = .blue
    let number: Double
    var isDarkColor: Bool {
        return UIColor(colorNumber).isDarkColor
    }
	@State var isActive: Bool = false
    @ObservedObject var state: CalculationState
	
	var numberString: String {
		if number == .pi {
			return "π"
		}
		
		return String(Int(number))
	}
    @State var width: CGFloat
    @State var height: CGFloat
    @State var zeroWidth: CGFloat? = 0
	
	var body: some View {
            Button(action: {

                if self.state.start {
                    self.state.toogleStart()
                }

                self.state.appendNumber(self.number)

                // Haptic effect
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()

            }, label: {
                Text(numberString)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(isDarkColor ? .white : .black)
                    .frame(width: self.number == 0 ? zeroWidth : width , height: width)
                    .background(colorNumber)
                    .cornerRadius(20)
                    .animation(.easeIn(duration: 0.1))
            })
            .shadow(radius: 8)
            .padding(1)

    }
}
