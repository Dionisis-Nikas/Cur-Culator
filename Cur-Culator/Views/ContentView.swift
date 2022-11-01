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
        GeometryReader { geometry in
            ZStack {
                VStack{
                    HStack(alignment: .top, spacing: geometry.size.width * 0.1){

                        ExchangeChart(converter: $converter, code: $code, currencySelection: $currencySelection, rate: $rate)
                        ConverterButton(converter: $converter, connection: connectionStatus)
                        Settings(showingPopover: $showingPopover, connection: connectionStatus, datas: readData, fetch: fetchData, width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)

                    }
                    .padding([.top,.leading,.trailing], geometry.size.width * 0.01)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.1)



                    // Number row
                    HStack(alignment: .top, spacing: 10){

                        NumberField(state: state, fetchData: fetchData, currencySelection: $currencySelection, code: $code, converter: $converter, rate: self.$rate, width: geometry.size.width * 0.95, height: geometry.size.height * 0.2)
                            .offset(x: converter ? 0 : 10)

                    }

                    .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.190)
                    .padding([.bottom], 14)



                    // Button row
                    VStack(alignment: .center) {
                        Text("Currency rates last updated at: " + self.time)
                            .font(.system(size: 14))

                        ButtonField(state: state,width: geometry.size.width * 0.2, height: geometry.size.width * 0.2, zeroWidth: (geometry.size.width * 0.42) + 15)

                    }

                    .padding([.bottom], geometry.size.height * 0.1)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.7)


                }

                SplashScreenView(fetchData: fetchData)
            } // end of ZStack
        } // end of Geometry
    } // end of Body


}
// end of Class


