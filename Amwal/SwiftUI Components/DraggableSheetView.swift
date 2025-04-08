//
//  DraggableSheetView.swift
//  Amwal
//
//  Created by Taha Hussein on 08/04/2025.
//

import SwiftUI
struct DraggableSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    let content: () -> Content

    @State private var dragOffset: CGFloat = 0

    var body: some View {
        if isPresented {
            ZStack(alignment: .bottom) {
                // Dimmed background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }

                // Main sheet view
                VStack(spacing: 0) {
                    VStack(spacing: 12) {
                        Capsule()
                            .fill(Color.gray.opacity(0.6))
                            .frame(width: 40, height: 6)
                            .padding(.top, 10)
                        content()
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.75)
                    .background(Color.warning) // or your custom background
                    .cornerRadius(20, corners: [.topLeft, .topRight]) // Top corner radius only
                    .clipped()
                }
                .offset(y: dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.height
                        }
                        .onEnded { value in
                            withAnimation {
                                if value.translation.height > 100 {
                                    isPresented = false
                                }
                                dragOffset = 0
                            }
                        }
                )
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isPresented)
            }
        }
    }
}
