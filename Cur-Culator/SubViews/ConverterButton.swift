//
//  ConverterButton.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/3/22.
//

import SwiftUI

struct ConverterButton: View {
    @Binding var converter: Bool
    var body: some View {
        VStack(alignment: .center){
            Text("Converter Mode")
                .font(.caption)


            Toggle("",isOn: $converter)
                .labelsHidden()
        }
        
    }
}
