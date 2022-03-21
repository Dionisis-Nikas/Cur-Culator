//
//  NumberView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI



struct NumberView: View {
	let number: Double
    @AppStorage("colorNumber") var colorNumber: Color = .blue
    var isDarkColor: Bool {
        return UIColor(colorNumber).isDarkColor
    }
	@State var isActive: Bool = false
	@Binding var state: CalculationState
	
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
                    //.shadow(color: Color.blue, radius: 10, x: 5, y: 5)
                    .animation(.easeIn(duration: 0.1))
            })
            .padding(1)

    }
}
