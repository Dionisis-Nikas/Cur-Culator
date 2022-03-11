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

                SwiftUIGIFPlayerView(gifName: "splashGIF")
                        .aspectRatio(contentMode: .fit)
                        .background(colorScheme == .dark ? Color.black : Color.white)
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
