//
//  SplashScreenView.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 10/3/22.
//

import SwiftUI
import SSSwiftUIGIFView

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("code") var code = "EUR"
    @AppStorage("convert") var currencySelection = "USD"
    var fetchData: FetchData

    @State var animationFinished: Bool = false
    @State var alertShow: Bool = false

    var body: some View {
        if !animationFinished {
            ZStack {

                Color(colorScheme == .dark ? UIColor.black : UIColor.white)
                VStack(alignment: .center) {
                SwiftUIGIFPlayerView(gifName: "splashGIF")
                        .aspectRatio(contentMode: .fit)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        .frame(alignment: .center)
                        .padding([.trailing], 16)
                        .padding([.leading], 16)
                Text("Cur-Culator")
                    .padding([.top],30)
                    .padding([.bottom],15)

                    .font(Font.system(size: 36, weight: .bold))
                Text("© 2022 Cur-Culator. All Rights Reserved.")
                    .font(Font.system(size: 17, weight: .ultraLight))
                }



            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                fetchData.fetch(withBase: code, withTarget: currencySelection, completion: {
                    animationFinished = true
                }, errorHandler: {
                    alertShow = true
                })
            })


            }
            .alert(isPresented: $alertShow, content: {

                Alert(title: Text("Something went wrong"), message: Text("Something went wrong and currency rates are not updated. Please try again later."),dismissButton: Alert.Button.default(
                    Text("OK"), action: {
                        alertShow = false
                        animationFinished = true
                    }))

            })

        }
    }

}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
