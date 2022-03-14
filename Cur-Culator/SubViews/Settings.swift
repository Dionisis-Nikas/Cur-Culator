//
//  Settings.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 4/10/21.
//

import SwiftUI

struct Settings: View {
    @AppStorage("code") private var code = "USD"
    @AppStorage("convert") private var currencySelection = "USD"
	@State private var showingPopover = false
	@State var alert = false
    @State var submit = false
    @State var retry = false

	@State var datas: ReadData
	@State var fetch: FetchData

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
                    .background(Color.gray)
                    .cornerRadius(30)

                    
            })


		.popover(isPresented: $showingPopover) {

			NavigationView{
				Form {
					Picker(selection: $base, label: Text("Base currency")) {
						
						
						Filter(codes: datas.codes, names: datas.names )
					}
					Picker(selection: $target, label: Text("Target currency")) {
						
						
						Filter(codes: datas.codes, names: datas.names )
					}
					
                    Button(action: {
                        self.alert.toggle()
                        if self.code != self.base || self.currencySelection != self.target {
                            self.submit.toggle()
                            code = self.base
                            currencySelection = self.target
                            fetch.getData()
                        } else {
                            self.retry.toggle()
                        }
						
                    }, label: {
                        Text("Save")
                            .font(.headline)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)


                            .foregroundColor(Color.white)
                    })
                        .listRowBackground(Color.blue.opacity(self.submit ? 0.5 : 1.0))
                    


					.alert(isPresented: $alert, content: {
                        Alert(title: Text(retry ? "No changes" : "Saved"), message: Text(retry ? "Make some changes before you save your selection again." : "Updated base currency to  " + code + "  and target currency to " + currencySelection),dismissButton: Alert.Button.default(
                            Text("OK"), action: {
                                if self.retry {
                                    self.retry.toggle()
                                } else {
                                    self.submit.toggle()
                                }
                                }))
					})

				}
				.navigationBarTitle("Settings")
                .navigationBarItems(leading:
                        Button(action: {
                            self.showingPopover.toggle()
                        }) {
                        Image(systemName: "chevron.backward.circle").imageScale(.large)
                        Text("Back")
                    }
                    .imageScale(.large)
                )
				.padding(.top, 20)
				
			}
			
		}

		
	}
}


