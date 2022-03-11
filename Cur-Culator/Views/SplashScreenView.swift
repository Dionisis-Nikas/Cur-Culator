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
    @State var animationFinished: Bool = false

    var body: some View {

        ZStack {
            if !animationFinished {
                Color(colorScheme == .dark ? UIColor.black : UIColor.white)
                VStack(alignment: .center, spacing: 15) {
                SwiftUIGIFPlayerView(gifName: "splashGIF")
                        .aspectRatio(contentMode: .fit)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                Text("Cur-Culator")
                    .padding()
                    .font(Font.system(size: 60, weight: .bold))
                Text("© 2022 Cur-Culator. All Rights Reserved.")
                    .padding()
                    .font(Font.system(size: 17, weight: .ultraLight))
                }



            }

        }.background(colorScheme == .dark ? Color.black : Color.white)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                animationFinished = true
            })
        }
    }

}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
