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
    var fetchData: FetchData

    @State var animationFinished: Bool = false

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
            .onAppear {
                fetchData.fetch()

                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {

                    animationFinished = true
                })
            }

        }
    }

}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
