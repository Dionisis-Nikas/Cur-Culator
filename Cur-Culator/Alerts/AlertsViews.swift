//
//  AlertsViews.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 13/11/22.
//

import SwiftUI

enum AlertType {

    
    case errorBackend(action: () -> Void?)

    case noInternet(action: () -> Void?)

    func getView() -> Alert {
        switch self {
        case .errorBackend(let action):
            return Alert(title: Text("Something went wrong"), message: Text("Something went wrong. Please try again. Your selection will be reset to previous values."), dismissButton: Alert.Button.default(
                Text("OK"), action: {
                    action()
                }))
        case .noInternet(action: let action):
            return Alert(title: Text("Internet connection required"), message: Text("No internet connection detected. Please check your internet settings and try again."), dismissButton: Alert.Button.default(
                Text("OK"), action: {
                    action()
                }))

        }
    }

}
