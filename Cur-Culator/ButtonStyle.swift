//
//  ButtonStyle.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 5/10/21.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
	
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.font(.headline)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			.contentShape(Rectangle())
			.foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
			.listRowBackground(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
	}
}
