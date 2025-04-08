//
//  ImageExtension.swift
//  RER
//
//  Created by Maha Alsharikh on 03/03/1445 AH.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Image {
    /// Initializes a SwiftUI `Image` from data.
    init?(data: Data?) {
        guard let data = data else {return nil}
        #if canImport(UIKit)
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
        #elseif canImport(AppKit)
        if let nsImage = NSImage(data: data) {
            self.init(nsImage: nsImage)
        } else {
            return nil
        }
        #else
        return nil
        #endif
    }
    
    func inCircle() -> some View {
        modifier(CenterInCircle())
    }
    
    func inDashedCircle() -> some View {
        modifier(CenterInDashedCircle())
    }
}
