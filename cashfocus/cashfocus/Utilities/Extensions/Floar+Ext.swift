//
//  Floar+Ext.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-11-05.
//
import Foundation

extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
