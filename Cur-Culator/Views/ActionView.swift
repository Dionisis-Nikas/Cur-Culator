//
//  ActionView.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 1/10/21.
//

import SwiftUI

struct ActionView:View {
    
    @AppStorage("colorActionInactive") var colorAction: Color = .green
    var isDarkColor: Bool {
        return UIColor(colorAction).isDarkColor
    }
    var invertedColor: UIColor {
        return UIColor(colorAction).inverted
    }

    enum Action {
		case equal, clear, plus, minus, mutliply, divide, sign, percent
		
		func image() -> Image {
			switch self {
				case .equal:
					return Image(systemName: "equal")
				case .clear:
					return Image(systemName: "trash")
				case .plus:
					return Image(systemName: "plus")
				case .minus:
					return Image(systemName: "minus")
				case .mutliply:
					return Image(systemName: "multiply")
				case .divide:
					return Image(systemName: "divide")
				case .sign:
					return Image(systemName: "plus.slash.minus")
				case .percent:
					return Image(systemName: "percent")
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
	
	let action: Action
	@Binding var state: CalculationState
    @State var width: CGFloat
    @State var height: CGFloat

	
	var body: some View {
            Button(action: tapped, label: {
                action.image()
                    .font(Font.title.weight(.bold))
                    .frame(width: width, height: height)
                    .foregroundColor(isDarkColor ? .white : .black)
                    .background(state.storedAction == action ? Color(invertedColor) : colorAction)
                    .cornerRadius(20)
                    .shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 10)
            })
            .padding(1)
		
	}
	
	private func tapped() {
		switch action {
			case .clear:
				state.currentNumber = 0
				state.storedNumber = nil
				state.storedAction = nil
                state.start = true
				state.decimal = false
				state.level = 1
				state.edit = true
				break
				
			case .sign:
				state.currentNumber = state.currentNumber * (-1)
				break
				
			case .percent:
				state.level = 1
				state.currentNumber = state.currentNumber / 100
				state.decimal = false
				state.edit = false
				state.storedNumber = nil
				state.storedAction = nil
				break
				
			case .equal:
				
				guard let storedAction =
						state.storedAction else{
							return
						}
				guard let storedNumber =
						state.storedNumber else {
							return
						}
				
				guard let result = storedAction.calculate(storedNumber, state.currentNumber) else {
					return
				}
				state.storedNumber = nil
				state.storedAction = nil
				state.decimal = false
				state.level = 1
				state.edit = true
				state.currentNumber = result
                state.start = true
				
				break
				
			default:
				state.decimal = false
				
				if state.storedAction != nil {
					guard let storedAction =
							state.storedAction else{
						return
					}
                    if storedAction != action {
                        state.storedAction = action
                    }
					guard let storedNumber =
							state.storedNumber else {
						return
					}
                    if !state.start {
                        guard let result = storedAction.calculate(storedNumber, state.currentNumber) else {
                            return
                        }
                        state.currentNumber = result
                        state.edit = false
                        state.storedNumber = state.currentNumber
                        state.start = true
                    }



				}
				else{
					state.storedAction = action
                    state.storedNumber = state.currentNumber
                    state.start = true
					state.currentNumber = 0
					state.edit = true
				}
				state.level = 1
				break
		
		}
	}
}
