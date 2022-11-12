//
//  SaveButton.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/11/22.
//

import SwiftUI

struct SaveButton: View {
    @State var action : () -> Void
    @Binding var hasSubmitted: Bool
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text("Save")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 48)
                .foregroundColor(Color.white)
                .padding(.horizontal, 16)
                .cornerRadius(16)
                .background(Color.blue
                                .opacity(self.hasSubmitted ? 0.5 : 1.0)
                                .cornerRadius(16)
                                .padding(.horizontal, 16))

        })

        .padding(.vertical, 16)

    }
}


