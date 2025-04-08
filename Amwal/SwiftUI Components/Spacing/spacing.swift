//
//  spacing.swift
//  RER
//
//  Created by Maha Alsharikh on 26/03/1445 AH.
//

import Foundation

extension CGFloat {
    private struct SpacingPrimitives {
        static let zero: CGFloat = 0
        static let quarter: CGFloat = 2
        static let half: CGFloat = 4
        static let one: CGFloat = 8
        static let two: CGFloat = 16
        static let three: CGFloat = 24
        static let four: CGFloat = 32
        static let five: CGFloat = 40
        static let six: CGFloat = 48
        static let seven: CGFloat = 56
        static let eight: CGFloat = 64
        static let nine: CGFloat = 72
        static let ten: CGFloat = 80
        static let eleven: CGFloat = 88
        static let twelve: CGFloat = 96
        static let thirteen: CGFloat = 104
        static let fourteen: CGFloat = 112
        static let fifteen: CGFloat = 120
    }
    
    struct Spacing {
        static let none = SpacingPrimitives.zero
        static let xs4_Space = SpacingPrimitives.quarter
        static let xs3_Space = SpacingPrimitives.half
        static let xs2_Space = SpacingPrimitives.one
        static let xs_Space = SpacingPrimitives.two
        static let s_Space = SpacingPrimitives.three
        static let m_Space = SpacingPrimitives.four
        static let l_Space = SpacingPrimitives.five
        static let xl_Space = SpacingPrimitives.six
        static let xl7_Space = SpacingPrimitives.seven
        static let xl8_Space = SpacingPrimitives.eight
        static let xl9_Space = SpacingPrimitives.nine
        static let xl10_Space = SpacingPrimitives.ten
    }
    
    struct Padding {
        static let stepsContainerMargin = SpacingPrimitives.fourteen
        static let pageConetntMargin = SpacingPrimitives.three
        static let mainScreenPadding = SpacingPrimitives.three
        static let fieldsVerticalSpacing = SpacingPrimitives.three
        
    }
}
