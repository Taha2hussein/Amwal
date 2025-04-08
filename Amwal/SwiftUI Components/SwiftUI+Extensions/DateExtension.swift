//
//  DateExtension.swift
//  wahed
//
//  Created by Sihem MOHAMED on 2/10/20.
//  Copyright © 2020 Elm. All rights reserved.
//

import Foundation

var backendFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    return dateFormatter
}

extension Date {
    
    var hijriCalendar: Calendar {
        var calendar = Calendar(identifier: .islamicUmmAlQura)
        calendar.locale = Locale(identifier: "ar_SA")
        return calendar
    }
    
    var gregorianCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US")
        return calendar
    }
    
    static func formatStringHijriDate(strDate: String)-> String {
        let date = backendFormatter.date(from: strDate)
        return date?.getFormattedDate(format: "dd/MM/yyyy") ?? "-"
    }
    
    static func formatStringGregorianDate(strDate: String, fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS", toFormat: String = "yyyy/MM/dd hh:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = fromFormat
        let date = dateFormatter.date(from: strDate)
        dateFormatter.dateFormat = toFormat
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    var gregorianToHijri: String {
        var calendar = Calendar(identifier: .islamicUmmAlQura)
        calendar.locale = Locale(identifier: "ar_SA")
        let flags : Set<Calendar.Component> = [.year, .month, .day]
        let date = calendar.startOfDay(for: self)
        let dateComponents = calendar.dateComponents(flags, from: date)
        return "\(dateComponents.day!)/\(dateComponents.month!)/\(dateComponents.year!)"
    }
    
    var hijriToGregorian: String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US")
        let flags : Set<Calendar.Component> = [.year, .month, .day]
        let date = calendar.startOfDay(for: self)
        let dateComponents = calendar.dateComponents(flags, from: date)
        return "\(dateComponents.day!)/\(dateComponents.month!)/\(dateComponents.year!)"
    }
    
    func getFormattedDate(format: String, locale: String = "en-US", calenderIdentifier: Calendar.Identifier = .gregorian) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.locale = Locale(identifier: locale)
        dateformat.calendar = Calendar(identifier: calenderIdentifier)
        return dateformat.string(from: self)
    }
    
    
    
    func utcToLocal(dateStr: String, format : DateFormat = .one , includeTime : Bool = false) -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "W3C")
        dateFormatter.locale = Locale(identifier: "en-US")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
//            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.dateFormat = includeTime ? "HH:mm yyyy-MM-dd" : "yyyy-MM-dd"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }

    
    func getDifference(from: String, to: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let fromDate = dateFormatter.date(from: from){
            if let toDate = dateFormatter.date(from: to){
                let days = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
                if let diff = days.day{
                    return "\(diff)"
                }
                
                return "\((days.day ?? 0))"
            }
        }
        return ""
        
    }
    
   /* func getDifferenceByYearMonthDay(from: String, to: String) -> String{
        print("####\(from) and \(to)")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let fromDate = dateFormatter.date(from: from){
            if let toDate = dateFormatter.date(from: to){
                let days = Calendar.current.dateComponents([.day,.month,.year], from: fromDate, to: toDate)
                if let year = days.year{
                    if year != 0 {
                        return "\(year) \("year".localized())"
                    }
            
                }
                if let months = days.month{
                    if months != 0 {
                        if(months==2)
                        {
                            if languageManager.isAppArabic() {
                                return "\("month_dual".localized())"
                            }
                            return "2 \("month_dual".localized())"
                        }
                        if(months>2)
                        {
                            return "\(months) \("month_plural".localized())"}
                        return "\("month".localized())"
                    }
                }
                
                if let diff = days.day{
                    return "\(abs(diff + 1) + 1) \("days".localized())"
                }
                
                return "\(abs((days.day ?? 0) + 1)) \("days".localized())"
            }
        }
        return ""
        
    } */
    
    func getDifferenceByYearMonthDay(from: String, to: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let fromDate = dateFormatter.date(from: from),
           let toDate = dateFormatter.date(from: to) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: fromDate, to: toDate)
            
            if let year = components.year, year != 0 {
                return "\(year) \("year")"
            }
            
            if let months = components.month, months != 0 {
                let absoluteMonths = abs(months)
                if absoluteMonths == 1 {
                   
                    return "1 \("month")"
                } else {
                    let pluralKey = absoluteMonths > 1 ? "month_plural" : "month"
                    return "\(absoluteMonths) \(pluralKey)"
                }
            }
            
            if let days = components.day {
                let absDays = abs(days) + 1
                return "\(absDays) \("days")"
            }
        }
        
        return ""
    }
    
    func addYearToDate(current: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let currentDate = dateFormatter.date(from: current){
            if let nextYearDate = Calendar.current.date(byAdding: .year, value: 1, to: currentDate){
                return dateFormatter.string(from: nextYearDate)
            }
        }
        return ""
        
    }
    
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension Date {
    func getHijri(_ component: Calendar.Component, `var` calendar: Calendar = Calendar.current) -> Int {
        return hijriCalendar.component(component, from: self)
    }
    
    func getGregorian(_ component: Calendar.Component, `var` calendar: Calendar = Calendar.current) -> Int {
        return gregorianCalendar.component(component, from: self)
    }
}
enum DateFormat : String {
    case one = "yyyy-MM-dd'T'HH:mm:ss"
    case two = "yyyy-MM-dd'T'HH:mm:ss.SSS" 
    case three = "yyyy-MM-dd'T'HH:mm:ss.SSSZZ"
    case four = "yyyy-MM-dd HH:mm:ss +zzzz"
    case five = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    case six = "dd-MM-yyyy"
    case seven = "yyyy-MM-dd'T'HH:mm:ss.SS" 
}
                
