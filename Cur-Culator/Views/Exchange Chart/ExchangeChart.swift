//
//  ExchangeChart.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/3/22.
//

import SwiftUI

struct ExchangeChart: View {

    @Binding var code: String
    @Binding var currencySelection: String
    @Binding var rate: Double

    var rateString: String {
        return String(format: (self.rate.truncatingRemainder(dividingBy: 1) == 0 ? "%g" : "%.4f"), arguments: [self.rate])
    }
    var body: some View {
        VStack(alignment: .center) {
            HStack{
                Image(systemName: "chart.bar.xaxis")

                Text("1 " + code + " = \(rateString) " + currencySelection )

                    .animation(.easeIn)
                    .font(.caption2)
                    .minimumScaleFactor(0.1)

            }

            Button(action: {
                let tempCode = code
                code = currencySelection
                currencySelection = tempCode
                self.rate = 1 / rate

            }, label: {
                Image(systemName: "repeat.circle.fill")
                        .foregroundColor(Color.green)
                        .animation(.easeIn)
                        .imageScale(.large)

            })
        }
    }
}
