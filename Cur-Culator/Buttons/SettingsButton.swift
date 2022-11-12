//
//  Settings.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 4/10/21.
//

import SwiftUI
import StoreKit

struct SettingsButton: View {
    @AppStorage("code") private var code = "USD"
    @AppStorage("convert") private var currencySelection = "USD"
    @AppStorage("colorActionInactive") var colorAction: Color = .green
    @AppStorage("colorNumber") var colorNumber: Color = .blue
    @AppStorage("adFree") private var adFree = false

    @Binding  var showingPopover: Bool

    @ObservedObject var connection: ConnectionStatus
    @ObservedObject var datas: ReadData
    @ObservedObject var fetch: FetchData

    @State var base = ""
    @State var target = ""
    @State var width: CGFloat
    @State var height: CGFloat

    var body: some View {

        Button(action: {
            self.base = code
            self.target = currencySelection
            showingPopover = true
        }, label: {
            Image(systemName: "gear")
                .font(Font.title.weight(.bold))
                .foregroundColor(.black)
                .frame(width: width * 1.5, height: height * 1.5)
                .shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 10)
                .background(Color.gray.shadow(radius: 24))
                .cornerRadius(30)


        })
        .popover(isPresented: $showingPopover) {

            SettingsPopover(connection: connection, data: datas, fetch: fetch, showingPopover: $showingPopover, base: $base, target: $target, width: $width, height: $height)
        }
    }
}
