//
//  Color.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/14.
//

import UIKit.UIColor

enum Color {
    static let daangnBlack1 = UIColor(hex: "2C2C2C")
    static let daangnGray1 = UIColor(hex: "ECECEC")
    static let daangnGray2 = UIColor(hex: "F2F3F7")
    static let daangnWhite = UIColor(hex: "FFFFFF")
    static let daangnOrange = UIColor(hex: "FE7E35")

    /// Typo Color
    static let daangnBlack2 = UIColor(hex: "1A1A1A")
    static let daangnGray3 = UIColor(hex: "959595")
    static let daangnGray4 = UIColor(hex: "7D7D7D")
    static let daangnGray5 = UIColor(hex: "DFDFDF")
}

fileprivate extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
            var hexInt: UInt32 = 0
            let scanner = Scanner(string: hex)
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
            scanner.scanHexInt32(&hexInt)

            let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
            let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
            let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
            let alpha = alpha

            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
}
