//
//  DoubleExtension.swift
//  RER
//
//  Created by Maha Alsharikh on 08/04/1445 AH.
//

import Foundation
import UIKit

extension Double {
    func truncate(places : Int) -> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}

func roundToDecimals(number: Double, places: Int = 2) -> Double {
    let placesBy10: Double = pow(10.0, Double(places))
    let result = round(number * placesBy10) / placesBy10
    return result
}

func roundToDecimals(numberStr: String, places: Int = 2) -> Double {
    guard let number = Double(numberStr) else {return 0.0}
    let placesBy10: Double = pow(10.0, Double(places))
    let result = round(number * placesBy10) / placesBy10
    return result
}
