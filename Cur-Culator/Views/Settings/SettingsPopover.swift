//
//  SettingsPopover.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 20/10/22.
//

import SwiftUI
import StoreKit

struct SettingsPopover: View {

    @AppStorage("code") private var code = "USD"
    @AppStorage("convert") private var currencySelection = "USD"
    @AppStorage("colorActionInactive") var colorAction: Color = .green
    @AppStorage("colorNumber") var colorNumber: Color = .blue
    @AppStorage("adFree") private var adFree = false

    @State var alert = false
    @State var submit = false
    @State var retry = false
    @State var showConnectionAlert = false

    @ObservedObject var connection: ConnectionStatus
    @ObservedObject var data: ReadData
    @ObservedObject var fetch: FetchData

    @Binding  var showingPopover: Bool
    @Binding var base: String
    @Binding var target: String
    @Binding var width: CGFloat
    @Binding var height: CGFloat

    @State private var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    var body: some View {
        NavigationView{

            ZStack(alignment: .bottom) {
                Form {

                    Section(header: Text("Currencies")) {
                        CodePicker(selection: $base, title: "Base currency", connection: connection, data: data, fetch: fetch)
                        CodePicker(selection: $target, title: "Target currency", connection: connection, data: data, fetch: fetch)
                    }

                    Section(header: Text("Appearance")) {

                        ColorPicker("Number Button Color: ", selection: $colorNumber, supportsOpacity: false)
                        ColorPicker("Action Button Color: ", selection: $colorAction, supportsOpacity: false)

                    }
                    Section {
                        ReviewButton()
                    }

                    Section {
                        RemoveAdsButton()
                    }
                }
                .navigationTitle("Settings")
                .navigationBarItems(
                    trailing:
                        PopUpXButton(showingPopover: self.$showingPopover))

                VStack(spacing: 0) {

                    Spacer()
                    SaveButton(action: {

                        self.alert.toggle()
                        if connection.checkConnection() {

                            if self.code != self.base || self.currencySelection != self.target {
                                self.submit.toggle()
                                code = self.base
                                currencySelection = self.target
                                fetch.fetch()
                                if !adFree {
                                    self.showingPopover.toggle()
                                }
                            } else {
                                self.retry.toggle()
                            }
                        } else {
                            self.showConnectionAlert.toggle()
                        }



                    }, hasSubmitted: self.$submit)
                    .alert(isPresented: $alert, content: {

                        !self.showConnectionAlert ?

                        Alert(title: Text(retry ? "No changes" : "Saved"), message: Text(retry ? "No changes detected! Make some changes before you save your selection again." : "Updated Base Currency to  " + code + "  and Target Currency to " + currencySelection),dismissButton: Alert.Button.default(
                            Text("OK"), action: {
                                if self.retry {
                                    self.retry.toggle()
                                } else {
                                    self.submit.toggle()
                                }
                            }))

                        :

                        Alert(title: Text("Internet connection required"), message: Text("No internet connection detected please check your internet settings and try again."),dismissButton: Alert.Button.default(
                            Text("OK"), action: {
                                self.showConnectionAlert.toggle()
                            }))

                    })
                }


            }
        }
    }
}

