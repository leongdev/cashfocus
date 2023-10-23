//
//  UIColor+Ext.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

extension UIColor {
  
  // MARK: Custom Theme
  struct CashFocusTheme {
    
    static var primary: UIColor { return UIColor(
      red: 0.208,
      green: 0.78,
      blue: 0.349,
      alpha: 1)
    }
    
    static var secondary: UIColor { return UIColor(
      red: 0.141,
      green: 0.541,
      blue: 0.239,
      alpha: 1)
    }
  }
  
  
  // MARK: Hexadecimal Color Converter
  public convenience init?(hex: String) {
      let r, g, b, a: CGFloat

      if hex.hasPrefix("#") {
          let start = hex.index(hex.startIndex, offsetBy: 1)
          let hexColor = String(hex[start...])

          if hexColor.count == 8 {
              let scanner = Scanner(string: hexColor)
              var hexNumber: UInt64 = 0

              if scanner.scanHexInt64(&hexNumber) {
                  r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                  g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                  b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                  a = CGFloat(hexNumber & 0x000000ff) / 255

                  self.init(red: r, green: g, blue: b, alpha: a)
                  return
              }
          }
      }

      return nil
  }
}
