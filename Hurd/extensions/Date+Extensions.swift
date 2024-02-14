//
//  Date+Extensions.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/4/24.
//

import Foundation

extension Date {
    var monthDayYear: (Int, Int, Int) {
        let diffs = Calendar.current.dateComponents([.day,.year, .month], from: self)
        
        guard let month = diffs.month, let day = diffs.day, let year = diffs.year else { return (0,0,0) }
        
        return (month, day, year)
    }
}
