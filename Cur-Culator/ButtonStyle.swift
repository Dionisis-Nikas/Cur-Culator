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

            .listRowBackground(Color.blue.opacity(configuration.isPressed ? 0.5 : 1.0))
            .foregroundColor(Color.white)

        
	}
}
