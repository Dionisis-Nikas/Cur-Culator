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
    @AppStorage("convert") private var currencySelection = "EUR"
    @AppStorage("colorActionInactive") var colorAction: Color = .green
    @AppStorage("colorNumber") var colorNumber: Color = .blue
    @AppStorage("adFree") private var adFree = false

    @State var alert = false
    @State var isLoading = false
    @State var ovverideAlert = false
    @State var alertType: AlertType? = nil

    @ObservedObject var connection: ConnectionStatus
    @ObservedObject var data: ReadData
    @ObservedObject var fetch: FetchData

    @Binding  var showingPopover: Bool
    @Binding var base: String
    @Binding var target: String
    @Binding var width: CGFloat
    @Binding var height: CGFloat

    @State var tempBase: String?
    @State var tempTarget: String?

    @State private var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    func saveData() {
        self.alert = false
        self.isLoading = true
        if connection.checkConnection() {
            fetch.fetch(withBase: self.base, withTarget: self.target, completion: {
                self.isLoading = false
                code = self.base
                currencySelection = self.target
                tempBase = self.base
                tempTarget = self.target
            }, errorHandler: {
                self.isLoading = false
                self.alertType = .errorBackend(action: {
                    if let tempBase = tempBase, let tempTarget = tempTarget {
                        self.base = tempBase
                        self.target = tempTarget
                    }
                })
                self.alert = true
            })
        } else {
            DispatchQueue.main.async {
                self.isLoading = false
                if ovverideAlert {
                    self.ovverideAlert = false
                    return
                }

                self.alertType = .noInternet(action: {
                    if let tempBase = tempBase, let tempTarget = tempTarget {
                        self.base = tempBase
                        self.target = tempTarget
                        self.ovverideAlert = true
                    }
                })
                self.alert = true
            }

        }

    }

    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack {

                    VStack(spacing:0) {

                        Form {

                            Section(header: Text("Currencies")) {
                                CodePicker(selection: $base, filterOut: $target, title: "Base currency", data: data)
                                    .onChange(of: base, perform: { _ in
                                        saveData()
                                    })
                                CodePicker(selection: $target, filterOut: $base, title: "Target currency", data: data)
                                    .onChange(of: target, perform: { _ in
                                        saveData()
                                    })
                            }

                            Section(header: Text("Appearance")) {

                                ColorPicker("Number Button Color: ", selection: $colorNumber, supportsOpacity: false)
                                ColorPicker("Action Button Color: ", selection: $colorAction, supportsOpacity: false)

                            }
                            Section {
                                ReviewButton()
                            }

                            Section {
                                DonateButton()
                            }
                        }
                        .navigationTitle("Settings")
                        .navigationBarItems(
                            trailing:
                                PopUpXButton(showingPopover: self.$showingPopover))

                        .alert(isPresented: $alert, content: {

                            
                            self.alertType!.getView()
                        })

                    }
                    .blur(radius: self.isLoading ? 3 : 0)
                    .disabled(self.isLoading)
                    ProgressView("Loading...")
                        .frame(width: geometry.size.width / 2,
                               height: geometry.size.height / 5)
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                        .opacity(self.isLoading ? 1 : 0)
                }
            }
        }
        .onAppear {
            self.tempBase = self.code
            self.tempTarget = self.currencySelection
        }
    }
}

