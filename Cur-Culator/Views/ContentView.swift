//
//  ContentView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 30/9/21.
//

import SwiftUI

//struct ContentViewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct ContentView: View {

    @ObservedObject var state = CalculationState()
    @State var converter = false
    @State private var showingPopover = false
    @ObservedObject var connectionStatus = ConnectionStatus()
    @ObservedObject var fetchData = FetchData()
    @ObservedObject var readData = ReadData()
    @State var baseFlag: String? = nil
    @State var targetFlag: String? = nil

    @AppStorage("code") private var code = "EUR"
    @AppStorage("convert") private var currencySelection = "USD"
    @AppStorage("rate") private var rate = 0.0
    @AppStorage("updateTime") var time = ""


    var defaultNumberfontSize: CGFloat {
        guard let currentMode = UIScreen.main.currentMode else { return 24 }
        return currentMode.size.width / 8
    }

    var comparingNumberfontSize: CGFloat {
        guard let currentMode = UIScreen.main.currentMode else { return 12 }
        return currentMode.size.width / 16
    }
    

    var body: some View {
            ZStack {
                GeometryReader { geometry in
                    VStack(spacing: 0){
                        HStack(alignment: .center){

                            ExchangeChart(code: $code, currencySelection: $currencySelection, rate: $rate)
                            Spacer()
                            ConverterButton(converter: $converter, connection: connectionStatus)
                            Spacer()
                            SettingsButton(showingPopover: $showingPopover, connection: connectionStatus, datas: readData, fetch: fetchData, width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)


                        }
                        .frame(maxWidth: .infinity)
                        .padding(12)

                        .background(Color.secondary.opacity(0.25).cornerRadius(8).padding(.horizontal, 4))



                        // Number row
                        Spacer()
                        HStack(alignment: .center, spacing: 10){
                            NumberField(state: state, fetchData: fetchData, currencySelection: $currencySelection, code: $code, converter: $converter, rate: self.$rate, width: geometry.size.width * 0.95, height: geometry.size.height * 0.25)
                                .offset(x: converter ? 0 : 10)
                                
                        }

                        Spacer()

                        // Button row

                        VStack(alignment: .center) {
                            Text("Currency rates last updated at: " + self.time)
                                .font(.system(size: 14))

                            ButtonField(state: state,width: geometry.size.width * 0.2, height: geometry.size.width * 0.2, zeroWidth: geometry.size.width * 0.45)

                        }

                        .padding([.bottom], 8)
                        .frame(maxWidth: .infinity)

                    }


                    SplashScreenView(fetchData: fetchData)
                }
            } // end of ZStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)


    } // end of Body


}
// end of Class


