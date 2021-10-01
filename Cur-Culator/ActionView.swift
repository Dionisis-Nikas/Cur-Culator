//
//  ActionView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI

struct ActionView:View {
	enum Action {
		case equal, clear, plus, minus, mutliply, divide
		
		func image() -> Image {
			switch self {
				case .equal:
					return Image(systemName: "equal")
				case .clear:
					return Image(systemName: "xmark.cirlce")
				case .plus:
					return Image(systemName: "plus")
				case .minus:
					return Image(systemName: "minus")
				case .mutliply:
					return Image(systemName: "mutliply")
				case .divide:
					return Image(systemName: "divide")
			}
		}
		
		func calculate(_ input1: Double, _ input2: Double) -> Double? {
			switch self {
				case .plus:
					return input1 + input2
				case .minus:
					return input1 - input2
				case .mutliply:
					return input1 * input2
				case .divide:
					return input1 / input2
				default:
					return nil
			}
		}
	}
	
	let action:Action
	@Binding var state: CalculationState
	
	var body: some View {
		action.image()
			.font(Font.title.weight(.bold))
			.foregroundColor(.white)
			.frame(width: 64, height: 64)
			.background(Color.green)
			.cornerRadius(20)
			.shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 10)
		
	}
}
