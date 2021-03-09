//
//  DateHelper.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

struct DateHelper {
    static func compareDatesOnMonthAndDay(date: Date, against secondDate: Date) -> Bool {
        Calendar.current.dateComponents([.day, .month], from: date) == Calendar.current.dateComponents([.day, .month], from: secondDate)
    }
}
