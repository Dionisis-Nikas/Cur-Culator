//
//  CodePicker.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 20/10/22.
//

import SwiftUI

struct CodePicker: View {
    @Binding var selection: String
    @State var title: String
    @ObservedObject var connection: ConnectionStatus
    @ObservedObject var data: ReadData
    @ObservedObject var fetch: FetchData

    var body: some View {
        if #available(iOS 16.0, *) {
            Picker(selection: $selection, label: Text(title), content: ({
                Filter(codes: data.codes, names: data.names)
            }))
            .pickerStyle(.navigationLink)
        } else {
            Picker(selection: $selection, label: Text(title), content: ({
                Filter(codes: data.codes, names: data.names)
            }))
        }
    }
}

struct CodePicker_Previews: PreviewProvider {
    @State static var base = "USD"
    static var previews: some View {
        CodePicker(selection: $base, title:"Base currency", connection: ConnectionStatus(), data: ReadData(), fetch: FetchData())
    }
}
