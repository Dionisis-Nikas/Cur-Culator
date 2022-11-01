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
                        VStack {
                            NavigationLink("Base Currency", destination: CodePicker(selection: $base, title: "Base currency", connection: connection, data: data, fetch: fetch))


                            CodePicker(selection: $target, title: "Target currency", connection: connection, data: data, fetch: fetch)
                                .pickerStyle(.automatic)
                        }

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
                .navigationTitle("Seetings")
                .navigationBarItems(
                    trailing:
                            Button(action: {
                                self.showingPopover.toggle()
                            }) {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .font(Font.system(size: 24, weight: .bold))
                                .foregroundColor(Color.gray)
                                .padding(0)
                            })

                VStack(spacing: 0) {

                    Spacer()
                    Button(action: {

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



                    }, label: {
                        Text("Save")
                            .font(.headline)
                            .frame(maxWidth: .infinity, maxHeight: height * 1.5, alignment: .center)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 16)
                            .cornerRadius(16)
                            .background(Color.blue
                                            .opacity(self.submit ? 0.5 : 1.0)
                                            .cornerRadius(16)
                                            .padding(.horizontal, 16))

                    })

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
                    if !adFree && self.connection.checkConnection() {
                        BannerAd(unitID: "ca-app-pub-3940256099942544/2934735716")
                            .frame(maxWidth: .infinity,  maxHeight: 64)
                    }
                }
            }
        }
    }
}

