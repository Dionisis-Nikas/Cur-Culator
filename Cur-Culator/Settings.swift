//
//  Settings.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 4/10/21.
//

import SwiftUI

struct Settings: View {
	@State private var showingPopover = false
	@AppStorage("code") private var code = "USD"
	@AppStorage("convert") private var convert = "USD"
	@State var submit = false
	@State var datas: ReadData
	@State var fetch: FetchData
	@State var base = ""
	@State var target = ""
	
	var body: some View {
		
		Button(action: {
			self.base = code
			self.target = convert
			showingPopover = true
		}, label: {
			Image(systemName: "gear")
				.font(Font.title.weight(.bold))
				.foregroundColor(.black)
				.frame(width: 44, height: 44)
				
				.shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 10)
				.background(Color.gray)
				.cornerRadius(20)
				.offset(x: 10, y: 0)
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
						self.submit.toggle()
						code = self.base
						convert = self.target
						fetch.update()
						fetch.updateFlags(baseCode: code, targetCode: convert)
                    }, label: {
                        Text("Save")
                            .font(.headline)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)


                            .foregroundColor(Color.white)
                    })
                        .listRowBackground(Color.blue.opacity(self.submit ? 0.5 : 1.0))
                    


					.alert(isPresented: $submit, content: {
						Alert(title: Text("Saved"), message: Text("Updated base currency to  " + code + "  and target currency to " + convert))
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


