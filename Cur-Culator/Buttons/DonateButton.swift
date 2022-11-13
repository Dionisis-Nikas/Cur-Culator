//
//  RemoveAdsButton.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 20/10/22.
//

import SwiftUI

struct DonateButton: View {

    private var localeCurrency: String {
        let currencySymbol = Locale.current.currencySymbol
        guard let currencySymbol = currencySymbol else {
            return ""
        }
        return currencySymbol
    }

    var body: some View {
        Button (action: {

        },label: {
            Text("Donate with 0.99" + localeCurrency)
                .font(.headline)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .foregroundColor(Color.white)

        })
        .listRowBackground(Color.blue)
    }
}

struct RemoveAdsButton_Previews: PreviewProvider {
    static var previews: some View {
        DonateButton()
    }
}
