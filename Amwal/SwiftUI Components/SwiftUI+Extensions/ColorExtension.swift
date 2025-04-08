//
//  ColorExtension.swift
//  RER
//
//  Created by Maha Alsharikh on 16/12/1444 AH.
//

import SwiftUI
import UIKit

extension Color {
    
    //    struct RERbackground{
    static let actionPrimary = Color("background-action-primary")
    static let actionSecondary = Color("background-action-secondary")
    static let actionDisabled = Color("background-action-disable")
    static let actionPressed = Color("background-action-pressed")
    static let alert = Color("background-alert")
    static let disabled = Color("background-disabled")
    static let info = Color("background-info")
    static let invert = Color("background-invert")
    static let main = Color("background-main")
    static let primary = Color("background-primary")
    static let secondary = Color("background-secondary")
    static let success = Color("background-success")
    static let blue = Color("blue")
    static let surface = Color("background-surface")
    static let warning = Color("background-warning")
    static let focus = Color("background-focus")
    static let support2 = Color("background-support2")
    static let support = Color("background-support")
    static let yellow = Color("yellowbackgroundColor")
    static let grays = Color("background-secondary-light")

    struct RERborder{
        static let actionPrimary = Color("border-action-primary")
        static let actionSecondary = Color("border-action-secondary")
        static let alert = Color("border-alert")
        static let dimmed = Color("border-dimmed")
        static let disabled = Color("border-disabled")
        static let info = Color("border-info")
        static let invert = Color("border-invert")
        static let main = Color("border-main")
        static let primaryFocus = Color("border-primary-focus")
        static let primary = Color("border-primary")
        static let secondaryFocus = Color("border-secondary-focus")
        static let secondary = Color("border-secondary")
        static let success = Color("border-success")
        static let support = Color("border-support")
        static let warning = Color("border-warning")
    }
    
    struct RERicon{
        static let actionDisabled = Color("icon-action-disabled")
        static let actionPrimary = Color("icon-action-primary")
        static let actionSecondary = Color("icon-action-secondary")
        static let alert = Color("icon-alert")
        static let disabled = Color("icon-disabled")
        static let unselected = Color("icon-unselected")
        static let info = Color("icon-info")
        static let invert = Color("icon-invert")
        static let main = Color("icon-main")
        static let primary = Color("icon-primary")
        static let secondary = Color("icon-secondary")
        static let success = Color("icon-success")
        static let support = Color("icon-support")
        static let warning = Color("icon-warning")
    }
    
    struct RERtext{
        static let actionDisabled = Color("text-action-disabled")
        static let actionPrimary = Color("text-action-primary")
        static let actionSecondary = Color("text-action-secondary")
        static let alert = Color("text-alert")
        static let dimmed = Color("text-dimmed")
        static let disabled = Color("text-disabled")
        static let info = Color("text-info")
        static let invert = Color("text-invert")
        static let light = Color("text-light")
        static let main = Color("text-main")
        static let primary = Color("text-primary")
        static let secondary = Color("text-secondary")
        static let success = Color("text-success")
        static let support = Color("text-support")
        static let warning = Color("text-warning")
        static let black = Color("background-action-secondary")

    }
    
    func getStatusBackgroundColor() -> Color {
        switch self {
        case .RERtext.alert:
            return Color.alert // orange
        case .RERtext.success:
            return Color.success // green
        case .RERtext.info:
            return Color.info // blue
        case .RERtext.warning:
            return Color.warning // red
        default:
            return self.opacity(0.1)
        }
    }
    
    func getStatusBorderColor() -> Color {
        switch self {
        case .RERtext.alert:
            return .RERborder.alert // orange
        case .RERtext.success:
            return .RERborder.success // green
        case .RERtext.info:
            return .RERborder.info // blue
        case .RERtext.warning:
            return .RERborder.warning // red
        default:
            return self.opacity(0.1)
        }
    }
}

func hexToUIColor (hex:String, alpha: CGFloat? = CGFloat(1.0)) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha!
    )
}


extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
