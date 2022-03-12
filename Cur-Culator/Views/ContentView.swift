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
    @AppStorage("adFree") private var adFree = true
    @AppStorage("code") private var code = "USD"
    @AppStorage("convert") private var currencySelection = "USD"

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

    var baseFlag: String {
        return getFlag(currency: code)
    }

    var targetFlag: String {
        return getFlag(currency: currencySelection)
    }

    var defaultNumberfontSize: CGFloat {
        return UIScreen.main.currentMode!.size.width / 8
    }

    var comparingNumberfontSize: CGFloat {
        return UIScreen.main.currentMode!.size.width / 16
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack{
                    if !adFree {
                        BannerAd(unitID: "ca-app-pub-2653148471151264/7651558454")
                        .frame(maxHeight: 64, alignment: .center)
                    }
                    VStack{
                        // Top row
                        HStack(alignment: .center, spacing: 20){

                            ExchangeChart(converter: $converter, rates: rates, code: $code, currencySelection: $currencySelection, fetchData: fetchData)
                            ConverterButton(converter: $converter)
                            Settings(datas: readData, fetch: fetchData, width: geometry.size.width * 0.1,height: geometry.size.width * 0.1)

                        }.frame(width: geometry.size.width, height: geometry.size.height * 0.1)



                        // Number row
                        HStack(alignment: .center, spacing: 10){

                            NumberField(state: $state, fetchData: fetchData, currencySelection: $currencySelection, baseFlag: baseFlag, code: $code, targetFlag: targetFlag, converter: $converter, width: geometry.size.width * 0.95, height: geometry.size.height * 0.2)
                                .offset(x: converter ? 0 : 10)

                        }

                        .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.2)

                        // Button row
                        VStack(alignment: .center) {
                            ButtonField(state: $state,width: geometry.size.width * 0.2, height: geometry.size.width * 0.2, zeroWidth: (geometry.size.width * 0.42) + 15)
                        }
                        .padding([.bottom], 20)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.7)

                    }
                    if !adFree {
                        BannerAd(unitID: "ca-app-pub-2653148471151264/9195277241")
                                .frame(maxHeight: 64, alignment: .center)
                    }

                }

                SplashScreenView()
            } // end of ZStack

        } // end of Geometry
    } // end of Body
} // end of Class
