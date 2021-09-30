//
//  ContentView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 30/9/21.
//

import SwiftUI

struct CalculationState {
	var currentNumber: Double = 0
	
	mutating func appendNumber(_ number: Double) {
		if number.truncatingRemainder(dividingBy: 1) == 0
		&&
			currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
			currentNumber = 10 * currentNumber + number
		}
		else {
			currentNumber = number
		}
	}
}

struct ContentView: View {
	
	@State var state = CalculationState()
	
	var displayedString: String {
		return String(format: "%.2f", [state.currentNumber])
	}
	
    var body: some View {
		VStack(alignment: .trailing, spacing: 20){
			
			Spacer()
			
			Text(displayedString)
				.font(.largeTitle)
				.fontWeight(.bold)
				.lineLimit(3)
				.padding(.bottom, 64)
				
			
			HStack{
				NumberView(number: 1)
				Spacer()
				NumberView(number: 2)
				Spacer()
				NumberView(number: 3)
				Spacer()
				NumberView(number: 4)
				
			}
			HStack{
				NumberView(number: 5)
				Spacer()
				NumberView(number: 6)
				Spacer()
				NumberView(number: 7)
				Spacer()
				NumberView(number: 8)
				
			}
			HStack{
				NumberView(number: 9)
				Spacer()
				NumberView(number: 2)
				Spacer()
				NumberView(number: 3)
				Spacer()
				NumberView(number: 4)
				
			}
			HStack{
				NumberView(number: 1)
				Spacer()
				NumberView(number: 2)
				Spacer()
				NumberView(number: 3)
				Spacer()
				NumberView(number: 4)
				
			}
		}.padding(32)
    }
}


struct NumberView: View {
	let number: Double
	//@Binding var state: CalculationState
	
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
			//.onTapGesture {
				//self.state.appendNumber(number)
			//}
	}
}


