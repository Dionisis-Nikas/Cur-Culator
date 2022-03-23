//
//  ConverterButton.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 12/3/22.
//

import SwiftUI

struct ConverterButton: View {
    @Binding var converter: Bool
    @State var connection: ConnectionStatus
    @State var showAlert: Bool = false

    var body: some View {
        VStack(alignment: .center){
            Text("Converter Mode")
                .font(.caption)


            Toggle("",isOn: $converter)
                .onChange(of: converter) { value in
                    if !connection.checkConnection() && value {
                        self.showAlert.toggle()
                        self.converter = false
                    }
                }
                .labelsHidden()


        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Internet connection required"), message: Text("No internet connection detected please check your internet settings and try again."),dismissButton: Alert.Button.default(
                Text("OK"), action: {


                }))
        })
        
    }
}
