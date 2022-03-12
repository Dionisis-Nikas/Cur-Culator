//
//  ExchangeChart.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/3/22.
//

import SwiftUI

struct ExchangeChart: View {

    @Binding var converter: Bool
    @State var rates: String
    @Binding var code: String
    @Binding var currencySelection: String
    @State var fetchData: FetchData
    
    var body: some View {
        VStack(alignment: .center) {
            HStack{
                Image(systemName: "chart.bar.xaxis")
                    .opacity(converter ? 1 : 0)
                    .offset(x: converter ? 0 : -240, y: 0)
                    .animation(.easeIn)
                Text("1 USD = 21982 SOM" )//rates)
                    .opacity(converter ? 1 : 0)
                    .offset(x: converter ? 0 : -240, y: 0)
                    .animation(.easeIn)
                    .font(.caption)
            }

            Button(action: {
                let tempCode = code
                code = currencySelection
                currencySelection = tempCode
                fetchData.update()

            }, label: {
                Image(systemName: "repeat.circle.fill")
                        .opacity(converter ? 1 : 0)
                        .foregroundColor(Color.green)
                        .offset(x: converter ? 0 : -240, y: 0)
                        .animation(.easeIn)
                        .imageScale(.large)

            })



        }
    }
}
