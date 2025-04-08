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
    @State private var currentOffset: CGFloat = UIScreen.main.bounds.height * 0.25

    var body: some View {
        if isPresented {
            ZStack(alignment: .bottom) {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }

                VStack(spacing: 0) {
                    Capsule()
                        .frame(width: 40, height: 6)
                        .foregroundColor(.gray)
                        .padding(.top, 8)

                    content()
                        .frame(height: UIScreen.main.bounds.height * 0.75)
                        .padding(.top)

                }
                .cornerRadius(20)
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

