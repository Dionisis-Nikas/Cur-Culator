//
//  Settings.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 4/10/21.
//

import SwiftUI

struct Settings: View {
	@State private var showingPopover = false
	@State var receive = false
	@State var number = 1
	@AppStorage("code") private var code = "USD"
	@State var date = Date()
	@State var email = ""
	@State var submit = false
	@State var isSelected = false
	@AppStorage("numColor") private var numColor = "primary"
	@AppStorage("opColor") private var opColor = "green"

	@ObservedObject var datas = ReadData()

	
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
						ForEach(datas.file, id: \.code){ user in
							
							HStack(alignment: .firstTextBaseline, spacing: 10){
								
								Text(user.code)
									.font(.title3)
									.fontWeight(.heavy)
									.foregroundColor(Color.gray)
								
								
									Text(user.name)
										.font(.title3)
										.fontWeight(.bold)
										.foregroundColor(Color.green)
									
									
								
								
							}.padding()
						}
					}
					
				}
				.navigationBarTitle("Settings")
			}
		}
	}
}


