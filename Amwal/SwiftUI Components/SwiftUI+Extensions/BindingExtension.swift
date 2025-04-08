//
//  BindingExtension.swift
//  RER
//
//  Created by Maha Alsharikh on 24/12/1444 AH.
//

import Foundation
import SwiftUI

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
