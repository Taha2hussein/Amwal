//
//  Radius.swift
//  RER
//
//  Created by Maha Alsharikh on 26/03/1445 AH.
//

import Foundation

extension CGFloat {
    struct RERRadius {
        private struct Primitives {
            static let sharp: CGFloat = 0
            static let s_Raduis: CGFloat = 4
            static let m_Raduis: CGFloat = 6
            static let l_Raduis: CGFloat = 8
            static let xl_Raduis: CGFloat = 16
            static let xl2_Raduis: CGFloat = 40
            static let xl3_Raduis: CGFloat = 128
        }
        
        static let sharp = Primitives.sharp
        static let s_Raduis = Primitives.s_Raduis
        static let m_Raduis = Primitives.m_Raduis
        static let l_Raduis = Primitives.l_Raduis
        static let xl_Raduis = Primitives.xl_Raduis
        static let xl2_Raduis = Primitives.xl2_Raduis
        static let xl3_Raduis = Primitives.xl3_Raduis
    }
}
