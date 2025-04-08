//
//  Modifiers.swift
//  RER
//
//  Created by Maha Alsharikh on 21/04/1445 AH.
//

import Foundation
import SwiftUI
import Combine

struct SectionTitle: ViewModifier {
    let title: String
    let font: Font
    let forgroundColor: Color
    let bottomPadding: CGFloat
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Text(title)
                    .font(font)
                    .foregroundStyle(forgroundColor)
                    .padding(.bottom, bottomPadding)
                Spacer()
            }
            content
        }
    }
}

struct HomeSectionHeader: ViewModifier {
    let title: String
    let callback: () -> ()
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title)
                    .font(.RERTitles.title3)
                    .foregroundStyle(Color.RERtext.primary)
                Spacer()
                Button {
                    callback()
                } label: {
                    Text("viewAll")
                }.buttonStyle(RERPlainTextButtonStyle( alignment: .trailing))
            }.padding(.vertical, .Spacing.xs3_Space).padding(.bottom, .Spacing.xs2_Space)
            content
        }
    }
}

struct IconSectionTitle: ViewModifier {
    let title: String
    let icon: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Image(icon)
                Text(title)
                    .font(.RERBody.bold)
                    .foregroundStyle(Color.RERtext.dimmed)
            }
            .padding(.bottom,.Spacing.xs2_Space)
            
            content
        }
    }
}

struct CenterInCircle: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Circle().stroke(lineWidth: 1).foregroundColor(.RERborder.dimmed)
            content
        }
        
    }
}

struct AppEnvironments: ViewModifier {
    @AppStorage("isDarkModeOn") var isDarkModeOn: Bool = false
    func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkModeOn ? .dark : .light)
            .environment(\.layoutDirection,  LayoutDirection.leftToRight)
    }
}

struct CenterInDashedCircle: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Circle().stroke(style: StrokeStyle(lineWidth: 1, dash: [3])).foregroundColor(.RERborder.dimmed)
            content
        }
        
    }
}

struct GetHeightModifier: ViewModifier {
    @Binding var height: CGFloat
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo -> Color in
                DispatchQueue.main.async {
                    height = geo.size.height
                }
                return Color.clear
            }
        )
    }
}

struct AdaptsToKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.currentHeight)
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            withAnimation(.easeOut(duration: 0.16)) {
                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                            }
                        }
                        .map { rect in
                            rect.height - geometry.safeAreaInsets.bottom
                        }
                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                    
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                        }
                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                })
        }
    }
}

struct ViewFirstAppearModifier: ViewModifier {
    @State private var didAppearBefore = false
    private let action: () -> Void

    init(perform action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            guard !didAppearBefore else { return }
            didAppearBefore = true
            action()
        }
    }
}
