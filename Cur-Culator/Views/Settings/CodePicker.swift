//
//  CodePicker.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 20/10/22.
//

import SwiftUI

struct CodePicker: View {
    @Binding var selection: String
    @Binding var filterOut: String
    @State var title: String
    @ObservedObject var data: ReadData

    var body: some View {
        if #available(iOS 16.0, *) {
            Picker(selection: $selection, label: Text(title), content: ({
                Filter(codes: data.codes, filterOut: $filterOut)
            }))
            .pickerStyle(.navigationLink)

        } else {
            Picker(selection: $selection, label: Text(title), content: ({
                Filter(codes: data.codes, filterOut: $filterOut)
            }))

        }
    }
}
