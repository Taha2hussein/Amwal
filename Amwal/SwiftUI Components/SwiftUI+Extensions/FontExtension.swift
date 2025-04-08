//
//  FontExtension.swift
//  RER
//
//  Created by Maha Alsharikh on 15/12/1444 AH.
//

import Foundation
import SwiftUI



extension Font {
    static var scale: CGFloat = 1
    
    enum RERFont: String {
        case black = "SFPRODISPLAYBLACKITALIC"
        case bold = "SFPRODISPLAYBOLD"
        case extraBold = "SFPRODISPLAYHEAVYITALIC"
        case extraLight = "SFPRODISPLAYLIGHTITALIC"
        case light = "SFPRODISPLAYTHINITALIC"
        case medium = "SFPRODISPLAYMEDIUM"
        case regular = "SFPRODISPLAYREGULAR"
        case semiBold = "SFPRODISPLAYSEMIBOLDITALIC"
    }
    
    struct RERTitles {
        static let title1 = Font.custom(RERFont.extraBold.rawValue, size: 28 * scale)
        static let title2 = Font.custom(RERFont.bold.rawValue, size: 23 * scale)
        static let title3 = Font.custom(RERFont.bold.rawValue, size: 18 * scale)
    }
    
    struct RERBody {
        static let bold = Font.custom(RERFont.bold.rawValue, size: 15 * scale)
        static let semi = Font.custom(RERFont.semiBold.rawValue, size: 15 * scale)
        static let meduim = Font.custom(RERFont.medium.rawValue, size: 15 * scale)
        static let regular = Font.custom(RERFont.regular.rawValue, size: 13 * scale)
    }
    
    struct RERCaption1 {
        static let bold = Font.custom(RERFont.bold.rawValue, size: 20 * scale)
        static let semi = Font.custom(RERFont.semiBold.rawValue, size: 16 * scale)
        static let regular = Font.custom(RERFont.regular.rawValue, size: 13 * scale)
    }
    
    struct RERCaption2 {
        static let small = Font.custom(RERFont.bold.rawValue, size: 11 * scale)
        static let smallLight = Font.custom(RERFont.regular.rawValue, size: 12 * scale)
    }
    
    struct RERIcon {
        static let navBar = Font.custom(RERFont.bold.rawValue, size: 12 * scale)
        static let fieldActionSolid = Font.custom(RERFont.regular.rawValue, size: 12 * scale)
        static let topActions = Font.custom(RERFont.light.rawValue, size: 22 * scale)
        static let fieldAction = Font.custom(RERFont.regular.rawValue, size: 20 * scale)
        static let menuIcon = Font.custom(RERFont.regular.rawValue, size: 12 * scale)
        static let action = Font.custom(RERFont.regular.rawValue, size: 12 * scale)
        static let smallAction = Font.custom(RERFont.regular.rawValue, size: 12 * scale)
        static let tinyAction = Font.custom(RERFont.regular.rawValue, size: 12 * scale)
    }
    
    static func RERCustomFont(_ font: RERFont, size: CGFloat) -> Font {
        return Font.custom(font.rawValue, size: size * scale)
    }
    
}
