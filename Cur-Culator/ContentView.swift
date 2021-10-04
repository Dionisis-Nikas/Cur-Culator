//
//  ContentView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 30/9/21.
//

import SwiftUI



struct ContentView: View {
	
	@State var state = CalculationState()
	@State var converter = false

	@State private var selection = "Red"
	let colors = ["Red", "Green", "Blue", "Black", "Tartan"]
	var displayedString: String {
		return String(format: (state.currentNumber.truncatingRemainder(dividingBy: 1) == 0 ?
								"%.0f" : "%g"), arguments: [state.currentNumber])
	}
	
    var body: some View {
		VStack(alignment: .trailing, spacing: 20){
			HStack{
				CurrencySelector()
				
				
				VStack(alignment: .trailing, spacing: 5, content: {
					Text("Converter")
						
					Toggle(isOn: $converter) {
					}
				})
				Settings()
			}
			Spacer()
			
			Text(displayedString)
				
				.fontWeight(.bold)
				.lineLimit(3)
				.padding(.bottom, 5)
				.font(.system(size: 60))
				.onAppear {
					//FetchData()
				}
				
				
			HStack{
				ActionView(action: .clear, state: $state)
				Spacer()
				ActionView(action: .sign, state: $state)
				Spacer()
				ActionView(action: .percent, state: $state)
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
				CommaButtonView(state: $state)
				Spacer()
				ActionView(action: .equal, state: $state)
			}
		}.padding(32)
    }
}








struct CalculationState {
	var currentNumber: Double = 0
	var decimal: Bool = false
	
	var storedNumber: Double?
	var storedAction: ActionView.Action?
	
	
	mutating func appendNumber(_ number: Double) {
		
		if number.truncatingRemainder(dividingBy: 1) == 0
			&& currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
			if decimal {
				let level = String(Int(currentNumber)).count
				currentNumber = currentNumber  + number / (Double((10 * level)))
				decimal = false
			}
			else {
				currentNumber = 10 * currentNumber + number
			}
		}
		else {
			currentNumber = number
			if (decimal) {decimal = false}
		}
	}
}
