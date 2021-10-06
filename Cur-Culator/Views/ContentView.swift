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
	@State var rate = 0.0
	@ObservedObject var fetchData = FetchData()
	@ObservedObject var readData = ReadData()
	@AppStorage("code") private var code = "USD"
	@AppStorage("convert") private var currencySelection = "USD"
	
	
	var displayedString: String {
		return String(format: (state.currentNumber.truncatingRemainder(dividingBy: 1) == 0 ?
								(state.decimal && !state.after ? "%." + String(state.pre) + "f" : "%.0f") : "%g"), arguments: [state.currentNumber])
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
								"%g" : "%.3f"), arguments: [total])
		
	}
	
	var exchangeCurrency: String {
		
		guard self.fetchData.values.count > 0 else {
			return ""
		}
		let search = self.fetchData.currencyCode.firstIndex(of: currencySelection)
		let rate = self.fetchData.currencyCode[search ?? 0]
		
		return rate
		
	}
	
	var rates: String {
		guard self.fetchData.values.count > 0 else {
			return ""
		}
		let search = self.fetchData.currencyCode.firstIndex(of: currencySelection)
		let rate = self.fetchData.values[search ?? 0]
		let str = "1 " + code + " = " + String(format: (rate.truncatingRemainder(dividingBy: 1) == 0 ?
															"%g" : "%.3f"), arguments: [rate]) + " " + currencySelection
		return str
	}
	
	var baseFlag: UrlImageView {
		guard self.fetchData.baseFlagURL.count>0 else {
			return UrlImageView(urlString: "none")
		}
		
		return UrlImageView(urlString: fetchData.baseFlagURL)
			
	}
	
	var targetFlag: UrlImageView {
		guard self.fetchData.targetFlagURL.count>0 else {
			return UrlImageView(urlString: "none")
		}
		
		return UrlImageView(urlString: fetchData.targetFlagURL)
			
	}
	
	
    var body: some View {
		
		
		VStack(alignment: .trailing, spacing: 20){
			HStack{
				Image(systemName: "chart.bar.xaxis")
					.opacity(converter ? 1 : 0)
					.offset(x: converter ? 0 : -200, y: 0)
					.animation(.easeIn)
				Text(rates)
					.opacity(converter ? 1 : 0)
					.offset(x: converter ? 0 : -200, y: 0)
					.animation(.easeIn)
					.font(.system(size: 12))
					
				VStack(alignment: .center){
					Text("Converter Mode")
						.font(.system(size: 10))
						.foregroundColor(.gray)
						
					Toggle("",isOn: $converter)
						.offset(x: -UIScreen.main.bounds.width * (1 / 10), y: 0)
				}
				Settings(datas: readData, fetch: fetchData)
			}
			
			Spacer()
				
			HStack(alignment: .firstTextBaseline, spacing: 10){
				
				VStack(alignment: .center, spacing: 5){
					Text(displayedString)
						.padding(.bottom, 5)
						.font(.system(size: converter ? 35 : 60))
						.animation(.easeInOut)
						
					baseFlag
						.opacity(converter ? 1 : 0)
						.offset(x: converter ? 0 : -200, y: 0)
						.animation(.easeInOut)
						.frame(width: converter ? nil : 0, height: converter ? nil : 0)
					
					Text(code)
						.foregroundColor(.gray)
						.opacity(converter ? 1 : 0)
						.offset(x: converter ? 0 : -200, y: 0)
						.animation(.easeInOut)
						.frame(width: converter ? nil : 0, height: converter ? nil : 0)
				}
				.animation(.easeIn)
				.minimumScaleFactor(0.1)
				
				Text("=")
					.foregroundColor(.green.opacity(0.5))
					.opacity(converter ? 1 : 0)
					.offset(x: converter ? 0 : -200, y: 0)
					.animation(.easeInOut)
					.font(.system(size: 25))
					.frame(width: converter ? nil : 0, height: converter ? nil : 0)
				
				VStack(alignment: .center, spacing: 5){
					Text(exchangeNumber)
						.padding(.bottom, 5)
						.font(.system(size: 35))
					
					targetFlag
						
					Text(exchangeCurrency)
						.foregroundColor(.gray)
				}.opacity(converter ? 1 : 0)
				.offset(x: converter ? 0 : -200, y: 0)
				.minimumScaleFactor(0.1)
				.animation(.easeInOut)
				.frame(width: converter ? nil : 0, height: converter ? nil : 0)
				
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
