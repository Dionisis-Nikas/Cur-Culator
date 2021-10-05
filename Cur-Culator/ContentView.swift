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
	@ObservedObject var fetchData = FetchData()
	
	@State var currencySelection = 0
	
	var displayedString: String {
		return String(format: (state.currentNumber.truncatingRemainder(dividingBy: 1) == 0 ?
								"%.0f" : "%g"), arguments: [state.currentNumber])
	}
	
	var exchangeNumber: Double {
		
		guard self.fetchData.values.count > 0 else {
			return 0
		}
		let rate = self.fetchData.values[currencySelection]
		print(rate)
		let doubleAmount = Double(state.currentNumber)
		let total = rate * doubleAmount
		return total
		
	}
	
    var body: some View {
		
		
		VStack(alignment: .trailing, spacing: 20){
			HStack(alignment: .center, spacing: 50){
				Picker("Currency",selection: $currencySelection) {
					ForEach(0..<fetchData.currencyCode.count) {
						let currency = fetchData.currencyCode[$0]
						Text(currency)
					}
				}.pickerStyle(MenuPickerStyle())
				.id(UUID())
				.labelsHidden()
					
				Settings()
			}
			
			Text("\(exchangeNumber, specifier: "%g")")
			
			
			Text(displayedString)
				.padding(.bottom, 5)
				.font(.system(size: 50))
			
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
		}.padding(25)
	}
}








struct CalculationState {
	var currentNumber: Double = 0
	var decimal: Bool = false
	
	var storedNumber: Double?
	var storedAction: ActionView.Action?
	var after: Bool = false
	
	
	mutating func appendNumber(_ number: Double) {
		
		if number.truncatingRemainder(dividingBy: 1) == 0
			&& currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
			if decimal {
				let level = String(Int(currentNumber)).count
				currentNumber = currentNumber  + number / ((pow(10, Double(level))))
				
			}
			else {
				if after {
					currentNumber = 0 + number
					after = false
				}
				else {
					currentNumber = 10 * currentNumber + number
				}
			}
		}
		else {
			if (decimal) {
				let level = String(Double(currentNumber)).count - 1
				currentNumber = currentNumber  + number / ((pow(10, Double(level))))
			}
			
			
		}
	}
}
