//
//  ButtonField.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/3/22.
//

import SwiftUI

struct ButtonField: View {
    @ObservedObject var state: CalculationState
    @State var width: CGFloat
    @State var height: CGFloat
    @State var zeroWidth: CGFloat
    var body: some View {
        HStack(spacing: 15){
            ActionView(action: .clear, state: state, width: width,height: height)
            ActionView(action: .sign, state: state, width: width,height: height)
            ActionView(action: .percent, state: state, width: width,height: height)
            ActionView(action: .mutliply, state: state, width: width,height: height)
        }
        
        HStack(spacing: 15){
            NumberView(number: 7, state: state, width: width,height: height)
            NumberView(number: 8, state: state, width: width,height: height)
            NumberView(number: 9, state: state, width: width,height: height)
            ActionView(action: .divide, state: state, width: width,height: height)
        }

        HStack(spacing: 15){
            NumberView(number: 4, state: state, width: width,height: height)
            NumberView(number: 5, state: state, width: width,height: height)
            NumberView(number: 6, state: state, width: width,height: height)
            ActionView(action: .minus, state: state, width: width,height: height)
        }

        HStack(spacing: 15){
            NumberView(number: 1, state: state, width: width,height: height)
            NumberView(number: 2, state: state, width: width,height: height)
            NumberView(number: 3, state: state, width: width,height: height)
            ActionView(action: .plus, state: state, width: width,height: height)
        }

        HStack(spacing: 15){

            NumberView(number: 0, state: state, width: width,height: height, zeroWidth: zeroWidth)
            CommaButtonView(state: state, width: width,height: height)
            ActionView(action: .equal, state: state, width: width,height: height)
        }
    }
}
