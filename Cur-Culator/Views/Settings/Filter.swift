//
//  Filter.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 5/10/21.
//

import SwiftUI

struct Filter: View {

    @State var codes: [String]
    @State private var searchTerm: String = ""
    @Binding var filterOut: String

    var filteredCurrencies: [String] {
        codes.filter {
            searchTerm.isEmpty ? true : $0.lowercased().contains(searchTerm.lowercased())
        }
    }

    var body: some View {

        SearchBar(text: $searchTerm)
        HStack(alignment: .center, spacing: 10){

            Text(getFlag(currency:filterOut) + " " + filterOut)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.gray.opacity(0.6))

        }
        .padding(10)

        List(filteredCurrencies, id: \.self) { currencyItem in
            if currencyItem != filterOut {
                HStack(alignment: .center, spacing: 10){

                    Text(getFlag(currency:currencyItem) + " " + currencyItem)
                        .font(.title)
                        .fontWeight(.heavy)
                }
                .padding(10)
            }
            
        }

    }
}
