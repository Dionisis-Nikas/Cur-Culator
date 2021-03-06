//
//  NumberField.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/3/22.
//

import SwiftUI

struct NumberField: View {
    @Binding var state: CalculationState
    @State var fetchData: FetchData
    @Binding var currencySelection: String
    @Binding var code: String
    @Binding var converter: Bool
    @Binding var rate: Double
    @State var width: CGFloat
    @State var height: CGFloat
    
    var targetFlag: String {
        return getFlag(currency: currencySelection)
    }

    var baseFlag: String {
        return getFlag(currency: code)
    }

    var displayedString: String {
        let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 5
        let currentNumber = state.currentNumber
        var intNumber = 0
        if !currentNumber.isNaN && !currentNumber.isInfinite {
            intNumber = Int(currentNumber)
        } else if currentNumber.isInfinite {
            return String(currentNumber)
        } else {
            return "NaN"
        }
        let result = currentNumber / Double(intNumber)
        let currentCount = String(result - 1.0).count
        return state.currentNumber.truncatingRemainder(dividingBy: 1) == 0 || state.decimal && state.level != (currentCount - 2) ?

        String(format: (state.decimal && state.edit ? "%." + String(state.level - 1) + "f" : "%.0f"), arguments: [state.currentNumber])

        :

        formatter.string(from: NSNumber(value: state.currentNumber)) ?? "NaN"
    }

    var exchangeNumber: String {

        let doubleAmount = Double(state.currentNumber)
        let total = rate * doubleAmount
        return String(format: (total.truncatingRemainder(dividingBy: 1) == 0 ? "%g" : "%.3f"), arguments: [total])


    }
    
    var body: some View {
            VStack(alignment: .center, spacing: 5){
                Text(displayedString)
                    .font(.system(size:(converter ? height * 0.33 : height * 0.7)))
                    .animation(.easeInOut)

                Text(baseFlag)
                    .font(.system(size: height * 0.33))
                    .offset(x: converter ? 0 : -1000, y: 0)
                    .animation(.easeInOut)
                    .frame(width: converter ? nil : 0, height: converter ? nil : 0, alignment: .bottom)

                Text(code)
                    .foregroundColor(.gray)
                    .opacity(converter ? 1 : 0)
                    .offset(x: converter ? 0 : -1000, y: 0)
                    .animation(.easeInOut)
                    .frame(width: converter ? nil : 0, height: converter ? nil : 0)
            }
            .frame(width: converter ? nil : width, alignment: .trailing)

            .animation(.easeIn)
            .minimumScaleFactor(0.1)

            Text("=")
                .foregroundColor(.green.opacity(0.5))
                .opacity(converter ? 1 : 0)
                .offset(x: converter ? 0 : -1000, y: 0)
                .animation(.easeInOut)
                .font(.system(size: height * 0.25))
                .frame(width: converter ? nil : 0, height: converter ? nil : 0)

            VStack(alignment: .center, spacing: 5){
                Text(exchangeNumber)
                    .font(.system(size: height * 0.33))

                Text(targetFlag)
                    .font(.system(size: height * 0.33))
                    .offset(x: converter ? 0 : -1000, y: 0)
                    .animation(.easeInOut)
                    .frame(width: converter ? nil : 0, height: converter ? nil : 0, alignment: .bottom)

                Text(currencySelection)
                    .foregroundColor(.gray)
            }.opacity(converter ? 1 : 0)
            .offset(x: converter ? 0 : -1000, y: 0)
            .minimumScaleFactor(0.1)
            .animation(.easeInOut)
            .frame(width: converter ? nil : 0, height: converter ? nil : 0)

    }

}
