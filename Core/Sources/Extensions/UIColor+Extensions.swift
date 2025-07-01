//
//  UIColor+Extensions.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import UIKit

public extension UIColor {
    convenience init(hexValue: UInt64, alpha: CGFloat = 1.0) {
        self.init(
            displayP3Red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString = hex.replacingOccurrences(of: "#", with: "0x")
        var hexValue: UInt64 = 10_066_329
        Scanner(string: hexString).scanHexInt64(&hexValue)
        self.init(hexValue: hexValue, alpha: alpha)
    }

    func darker(by delta: CGFloat = 0.1) -> UIColor {
        adjust(by: -1 * delta)
    }

    func adjust(by delta: CGFloat) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(
            red: add(delta, toComponent: red),
            green: add(delta, toComponent: green),
            blue: add(delta, toComponent: blue),
            alpha: alpha
        )
    }
}

private extension UIColor {
    func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        max(0, min(1, toComponent + value))
    }
}
