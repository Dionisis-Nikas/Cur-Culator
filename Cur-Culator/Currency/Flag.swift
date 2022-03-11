//
//  Flag.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 6/10/21.
//

import Foundation


struct FlagData : Codable {
	let target_data: [String: String]
}

func getFlag(currency: String) -> String {
    let base = 127397
    var scalar = String.UnicodeScalarView()
    var code = currency
    switch code {
    case "ANG":
        code = "AOq"
    case "XAF":
        code = "CFq"
    case "XCD":
        code = "AGq"
    case "XDR":
        code = "Xq"
    case "XOF":
        code = "SNq"
    case "XPF":
        code = "TFq"
    default: break

    }
    code.removeLast()

    for i in code.utf16{
        let number = Int(i) + base
        if let unicodeScalar = UnicodeScalar(number) {
            scalar.append(unicodeScalar)
        }
    }

    return String(scalar)
}


