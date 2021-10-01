//
//  ContentView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 30/9/21.
//

import SwiftUI

struct CalculationState {
	var currentNumber: Double = 0
	
	var storedNumber: Double?
	var storedAction: ActionView.Action?
	
	
	mutating func appendNumber(_ number: Double) {
		
		if number.truncatingRemainder(dividingBy: 1) == 0
		&& currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
			currentNumber = 10 * currentNumber + number
		}
		else {
			currentNumber = number
		}
	}
	
	mutating func appendComma() {
		
		
	}
}

struct ContentView: View {
	
	@State var state = CalculationState()
	
	var displayedString: String {
		return String(format: (state.currentNumber.truncatingRemainder(dividingBy: 1) == 0 ?
								"%.0f" : "%g"), arguments: [state.currentNumber])
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
				ActionView(action: .clear, state: $state)
				Spacer()
				FunctionView(state: $state, function: .sinus)
				Spacer()
				FunctionView(state: $state, function: .tangens)
				Spacer()
				ActionView(action: .mutliply, state: $state)
			}
			
			HStack{
				NumberView(number: 7, state: $state)
				Spacer()
				NumberView(number: 8, state: $state)
				Spacer()
				NumberView(number: 9, state: $state)
				Spacer()
				ActionView(action: .divide, state: $state)
				
			}
			HStack{
				NumberView(number: 4, state: $state)
				Spacer()
				NumberView(number: 5, state: $state)
				Spacer()
				NumberView(number: 6, state: $state)
				Spacer()
				ActionView(action: .minus, state: $state)
				
			}
			HStack{
				NumberView(number: 1, state: $state)
				Spacer()
				NumberView(number: 2, state: $state)
				Spacer()
				NumberView(number: 3, state: $state)
				Spacer()
				ActionView(action: .plus, state: $state)
				
			}
			HStack{
				
				
				NumberView(number: 0, state: $state)
				Spacer()
				Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
					Text(",")
				})
				ActionView(action: .equal, state: $state)
			}
		}.padding(32)
    }
}








