//
//  TimeConvertion.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-11-05.
//

import Foundation

func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}
