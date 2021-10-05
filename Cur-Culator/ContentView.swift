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
	@ObservedObject var readData = ReadData()
	@AppStorage("code") private var code = "USD"
	@AppStorage("convert") private var currencySelection = "USD"

	
	
	
	var displayedString: String {
		return String(format: (state.currentNumber.truncatingRemainder(dividingBy: 1) == 0 ?
								"%.0f" : "%g"), arguments: [state.currentNumber])
	}
	
	var exchangeNumber: String {
		
		guard self.fetchData.values.count > 0 else {
			return ""
		}
		let search = self.fetchData.currencyCode.firstIndex(of: currencySelection)
		let rate = self.fetchData.values[search ?? 0]
		let doubleAmount = Double(state.currentNumber)
		let total = rate * doubleAmount
		return String(format: (total.truncatingRemainder(dividingBy: 1) == 0 ?
								"%.0f" : "%.3f"), arguments: [total])
		
	}
	
	var exchangeCurrency: String {
		
		guard self.fetchData.values.count > 0 else {
			return ""
		}
		let search = self.fetchData.currencyCode.firstIndex(of: currencySelection)
		let rate = self.fetchData.currencyCode[search ?? 0]
		
		return rate
		
	}
	
	
    var body: some View {
		
		
		VStack(alignment: .trailing, spacing: 20){
			Settings(datas: readData, fetch: fetchData)
				
			
			HStack{
				
				HStack(alignment: .center, spacing: 10){
					Text(exchangeNumber)
						.padding(.bottom, 5)
						.font(.system(size: 50))
					Text(exchangeCurrency)
						.foregroundColor(.gray)
					
				}
				
				
				HStack(alignment: .center, spacing: 10){
					Text(displayedString)
						.padding(.bottom, 5)
						.font(.system(size: 50))
					Text(code)
						.foregroundColor(.gray)
					
				}
			}
			HStack(alignment: .center, spacing: 50){
				
					
				
				VStack(alignment: .trailing){
					Text("Converter Mode")
						.font(.system(size: 10))
						.foregroundColor(.gray)
						.offset(x: 10, y: 0)
					Toggle("",isOn: $converter)
						
						
				}
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
		}.padding(25)
	}
}
