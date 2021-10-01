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
		&& currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
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
		print(state.currentNumber)
		return String(format: "%.2f", arguments: [state.currentNumber])
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
				NumberView(number: 1, state: $state)
				Spacer()
				NumberView(number: 2, state: $state)
				Spacer()
				NumberView(number: 3, state: $state)
				Spacer()
				NumberView(number: 4, state: $state)
				
			}
			HStack{
				NumberView(number: 5, state: $state)
				Spacer()
				NumberView(number: 6, state: $state)
				Spacer()
				NumberView(number: 7, state: $state)
				Spacer()
				NumberView(number: 8, state: $state)
				
			}
			HStack{
				NumberView(number: 9, state: $state)
				Spacer()
				NumberView(number: 2, state: $state)
				Spacer()
				NumberView(number: 3, state: $state)
				Spacer()
				NumberView(number: 4, state: $state)
				
			}
			HStack{
				NumberView(number: 1, state: $state)
				Spacer()
				ActionView(action: .clear, state: $state)
				Spacer()
				FunctionView(state: $state, function: .sinus)
				Spacer()
				FunctionView(state: $state, function: .cosinus)
				
			}
		}.padding(32)
    }
}








