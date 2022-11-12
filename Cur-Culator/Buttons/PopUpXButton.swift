//
//  PopUpXButton.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/11/22.
//

import SwiftUI

struct PopUpXButton: View {

    @Binding var showingPopover: Bool

    var body: some View {
        Button(action: {
            self.showingPopover.toggle()
        }) {
        Image(systemName: "x.circle.fill")
            .resizable()
            .font(Font.system(size: 24, weight: .bold))
            .foregroundColor(Color.gray)
            .padding(0)
        }
    }
}
