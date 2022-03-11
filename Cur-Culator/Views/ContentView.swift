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


    var displayedString: String {
        let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 5
        let currentNumber = state.currentNumber
        let intNumber = Int(currentNumber)
        let result = currentNumber / Double(intNumber)
        let currentCount = String(result - 1.0).count
        return state.currentNumber.truncatingRemainder(dividingBy: 1) == 0 || state.decimal && state.level != (currentCount - 2) ?

        String(format: (state.decimal && state.edit ? "%." + String(state.level - 1) + "f" : "%.0f"), arguments: [state.currentNumber])

        :

        formatter.string(from: NSNumber(value: state.currentNumber)) ?? "NaN"
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

//    var baseFlag: UrlImageView {
//        guard self.fetchData.baseFlagURL.count>0 else {
//            return UrlImageView(urlString: "none")
//        }
//
//        return UrlImageView(urlString: fetchData.baseFlagURL)
//
//    }
//
//    var targetFlag: UrlImageView {
//        guard self.fetchData.targetFlagURL.count>0 else {
//            return UrlImageView(urlString: "none")
//        }
//
//        return UrlImageView(urlString: fetchData.targetFlagURL)
//
//    }

    var baseFlag: String {
        return getFlag(currency: code)
    }

    var targetFlag: String {
        return getFlag(currency: currencySelection)
    }

    var maxWidth: CGFloat {
        return (UIScreen.main.currentMode!.size.width / 10 * 4) + 40 + 20
    }

    var defaultNumberfontSize: CGFloat {
        return UIScreen.main.currentMode!.size.width / 8
    }

    var comparingNumberfontSize: CGFloat {
        return UIScreen.main.currentMode!.size.width / 16
    }

    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center, spacing: 5){
                if !adFree {
                    BannerAd(unitID: "ca-app-pub-2653148471151264/7651558454")
                    .frame(maxHeight: 64, alignment: .center)
                }
                VStack(alignment: .trailing){
                HStack(alignment: .top){

                    VStack(alignment: .center) {
                        HStack{
                            Image(systemName: "chart.bar.xaxis")
                                .opacity(converter ? 1 : 0)
                                .offset(x: converter ? 0 : -240, y: 0)
                                .animation(.easeIn)
                            Text(rates)
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
                            fetchData.updateFlags(baseCode: code, targetCode: currencySelection)

                        }, label: {
                            Image(systemName: "repeat.circle.fill")
                                    .opacity(converter ? 1 : 0)
                                    .foregroundColor(Color.green)
                                    .offset(x: converter ? 0 : -240, y: 0)
                                    .animation(.easeIn)
                                    .imageScale(.large)
                                    .padding([.top], 1)
                        })



                    }.offset(x: -(UIScreen.main.currentMode?.size.width)! / 32, y: 0)

                    VStack(alignment: .center){
                        Text("Converter Mode")
                            .font(.caption)


                        Toggle("",isOn: $converter)
                            .labelsHidden()
                    }
                    .padding([.trailing], 20)
                    Settings(datas: readData, fetch: fetchData)
                }

                Spacer()

                HStack(alignment: .firstTextBaseline, spacing: 10){

                    VStack(alignment: .center, spacing: 5){
                        Text(displayedString)
                            .padding(.bottom, 5)
                            .font(.system(size: converter ? comparingNumberfontSize : defaultNumberfontSize))
                            .animation(.easeInOut)

                        Text(baseFlag)
                            .font(.system(size: 25))
                            .offset(x: converter ? 0 : -1000, y: 0)
                            .animation(.easeInOut)
                            .frame(width: converter ? nil : 0, height: converter ? nil : 0)

                        Text(code)
                            .foregroundColor(.gray)
                            .opacity(converter ? 1 : 0)
                            .offset(x: converter ? 0 : -1000, y: 0)
                            .animation(.easeInOut)
                            .frame(width: converter ? nil : 0, height: converter ? nil : 0)
                    }
                    .animation(.easeIn)
                    .minimumScaleFactor(0.1)

                    Text("=")
                        .foregroundColor(.green.opacity(0.5))
                        .opacity(converter ? 1 : 0)
                        .offset(x: converter ? 0 : -1000, y: 0)
                        .animation(.easeInOut)
                        .font(.system(size: comparingNumberfontSize - 5))
                        .frame(width: converter ? nil : 0, height: converter ? nil : 0)

                    VStack(alignment: .center, spacing: 5){
                        Text(exchangeNumber)
                            .padding(.bottom, 5)
                            .font(.system(size: comparingNumberfontSize))

                        Text(targetFlag)
                            .font(.system(size: 25))
                            .offset(x: converter ? 0 : -1000, y: 0)
                            .animation(.easeInOut)
                            .frame(width: converter ? nil : 0, height: converter ? nil : 0)

                        Text(exchangeCurrency)
                            .foregroundColor(.gray)
                    }.opacity(converter ? 1 : 0)
                    .offset(x: converter ? 0 : -1000, y: 0)
                    .minimumScaleFactor(0.1)
                    .animation(.easeInOut)
                    .frame(width: converter ? nil : 0, height: converter ? nil : 0)

                }
                .frame(maxWidth: maxWidth, alignment: .trailing)
                VStack(alignment: .center, spacing: 10) {
                    HStack(spacing: 10){
                        ActionView(action: .clear, state: $state)
                        ActionView(action: .sign, state: $state)
                        ActionView(action: .percent, state: $state)
                        ActionView(action: .mutliply, state: $state)
                    }
                    HStack(spacing: 10){
                        NumberView(number: 7, state: $state)
                        NumberView(number: 8, state: $state)
                        NumberView(number: 9, state: $state)
                        ActionView(action: .divide, state: $state)
                    }

                    HStack(spacing: 10){
                        NumberView(number: 4, state: $state)
                        NumberView(number: 5, state: $state)
                        NumberView(number: 6, state: $state)
                        ActionView(action: .minus, state: $state)
                    }

                    HStack(spacing: 10){
                        NumberView(number: 1, state: $state)
                        NumberView(number: 2, state: $state)
                        NumberView(number: 3, state: $state)
                        ActionView(action: .plus, state: $state)
                    }

                    HStack(spacing: 10){

                        NumberView(number: 0, state: $state)
                        CommaButtonView(state: $state)
                        ActionView(action: .equal, state: $state)
                    }
                }
                }
                if !adFree {
                    BannerAd(unitID: "ca-app-pub-2653148471151264/9195277241")
                            .frame(maxHeight: 64, alignment: .center)
                }

            }.padding(15)
            SplashScreenView()
        }

    }
}
