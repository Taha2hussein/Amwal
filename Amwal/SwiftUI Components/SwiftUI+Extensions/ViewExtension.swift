//
//  ViewExtension.swift
//  RER
//
//  Created by Maha Alsharikh on 17/12/1444 AH.
//

import SwiftUI

extension View {
    
    @ViewBuilder func `if`<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func sectionTitle(title: String, font: Font = .RERBody.bold, forgroundColor: Color = .RERtext.dimmed, bottomPadding: CGFloat = .Spacing.xs2_Space) -> some View {
        modifier(SectionTitle(title: title, font: font, forgroundColor: forgroundColor, bottomPadding: bottomPadding))
    }
    
    func homeSectionHeader(title: String, callback: @escaping () -> ()) -> some View {
        modifier(HomeSectionHeader(title: title, callback: callback))
    }
    
    func iconSectionTitle(title: String,icon : String) -> some View {
        modifier(IconSectionTitle(title: title, icon: icon))
    }
    
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
    
    func applyAppEnviroments() -> some View {
        modifier(AppEnvironments())
    }
//    func applyLayout() -> some View {
//        environment(\.layoutDirection, LanguageManager.shared.isAppArabic()  ? LayoutDirection.rightToLeft : LayoutDirection.leftToRight)
//    }
//    func applyTheme() -> some View {
//        environment(\.colorScheme, RERDefaults.isDarkModeOn ? .dark : .light)
//    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func getContentHeight(sheetHeight: Binding<CGFloat>) -> some View {
        modifier(GetHeightModifier(height: sheetHeight))
    }
    
    
    func adaptsToKeyboard() -> some View {
        return modifier(AdaptsToKeyboard())
    }
    
    func addCoordinateSpace(name: String) -> some View {
        if #available(iOS 17.0, *) {
            self.coordinateSpace(name: name)
        } else {
            self.coordinateSpace(name: name)
        }
    }
    
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(ViewFirstAppearModifier(perform: action))
    }
}



struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}


