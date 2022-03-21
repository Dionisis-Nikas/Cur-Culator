//
//  CommaButtonView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI

struct CommaButtonView: View {

	@Binding var state: CalculationState
    @State var width: CGFloat
    @State var height: CGFloat
    @AppStorage("colorNumber") var colorNumber: Color = .blue
    var isDarkColor: Bool {
        return UIColor(colorNumber).isDarkColor
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
                    .foregroundColor(isDarkColor ? .white : .black)
                    .frame(width: width, height: height)
                    .background(self.state.decimal ? Color(UIColor(colorNumber).inverted) : colorNumber)
                    .cornerRadius(20)
                    //.shadow(color: Color.blue, radius: 10, x: 5, y: 5)
                    .animation(.easeIn(duration: 0.1))
            })
            .padding(1)
        
	}
}
