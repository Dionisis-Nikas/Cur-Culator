//
//  ColorSaver.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 14/3/22.
//

import Foundation
import SwiftUI
import UIKit

extension Color: RawRepresentable {

    public init?(rawValue: String) {

        guard let data = Data(base64Encoded: rawValue) else{
            self = .black
            return
        }

        do{
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            self = Color(color)
        }catch{
            self = .black
        }

    }

    public var rawValue: String {

        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()

        }catch{

            return ""

        }

    }

}

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }

    var inverted: UIColor {
            var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
            self.getRed(&r, green: &g, blue: &b, alpha: &a)
            return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a) // Assuming you want the same alpha value.
        }
}
