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
	@State var submit = false
	@State var datas: ReadData
	@State var fetch: FetchData
	
	var body: some View {
		
		Button(action: {
			showingPopover = true
		}, label: {
			Image(systemName: "gear")
				.font(Font.title.weight(.bold))
				.foregroundColor(.gray)
				.frame(width: 64, height: 64)
				.offset(x: 20, y: 0)
				.shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 10)
		})
		.popover(isPresented: $showingPopover) {
			NavigationView{
				Form {
					Picker(selection: $code, label: Text("Base currency")) {
						
						
						Filter(codes: datas.codes, names: datas.names )
					}
					
					Button("Save") {
						self.submit.toggle()
						fetch.update()
					}
					.buttonStyle(BlueButtonStyle())
					.alert(isPresented: $submit, content: {
						Alert(title: Text("Saved"), message: Text("Updated base currency to " + code))
					})
				}
				.navigationBarTitle("Settings")
				.padding(.top, 20)
				
			}
			
		}
		
	}
}


