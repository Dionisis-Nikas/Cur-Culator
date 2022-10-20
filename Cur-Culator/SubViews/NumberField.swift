//
//  NumberField.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/3/22.
//

import SwiftUI

struct NumberField: View {
    @ObservedObject var state: CalculationState
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

    var exchangeNumber: String {

        let doubleAmount = Double(state.currentNumber)
        let total = rate * doubleAmount
        return String(format: (total.truncatingRemainder(dividingBy: 1) == 0 ? "%g" : "%.3f"), arguments: [total])


    }
    
    var body: some View {
            VStack(alignment: .center, spacing: 5){
                Text(state.displayString)
                    .font(.system(size:(converter ? height * 0.33 : height * 0.7)))
                    .animation(.easeInOut, value: converter)

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
