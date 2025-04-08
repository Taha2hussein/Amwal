//
//  Date.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import Foundation

extension Date{
    init(year:Int,month:Int,day:Int){
        let calender = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        self = calender.date(from: components)!
    }
}
