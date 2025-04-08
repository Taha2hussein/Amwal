//
//  SwappableViewsWithIndicator.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import SwiftUI

enum Page: Int, CaseIterable {
    case first, second, third

    @ViewBuilder
    func view(expandList: Binding<Bool>, selectedButtonIndex: Binding<Int?>,  onExpandTapped: @escaping () -> Void) -> some View {
        switch self {
        case .first:
            VStack(spacing: 10) {
                HStack(spacing: 8) {
                    Button("جميع الأسهم") {
                        selectedButtonIndex.wrappedValue = 1 // Button 1 selected
                    }
                    .buttonStyle(RERPrimaryButtonStyle(isSelected: selectedButtonIndex.wrappedValue == 1))

                    Button("المحفظة") {
                        selectedButtonIndex.wrappedValue = 2 // Button 2 selected
                    }
                    .buttonStyle(RERPrimaryButtonStyle(isSelected: selectedButtonIndex.wrappedValue == 2))

                    Button(action: {
                        onExpandTapped()
                        expandList.wrappedValue.toggle()
                    }) {
                        Image(expandList.wrappedValue == true ? "selectedExpand" : "Expand")
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .frame(height: 50)
                
//                List(0..<10, id: \.self) { index in
//                    Text(index.description)
//                }
//                .listStyle(.plain)
                PercentageList()
                .frame(height: expandList.wrappedValue ? 400 : 250)
            }

        case .second:
            VStack(spacing: 10) {
                HStack(spacing: 8) {
                    Button("المنخفضة") {
                        selectedButtonIndex.wrappedValue = 1 // Button 1 selected
                    }
                    .buttonStyle(RERPrimaryButtonStyle(isSelected: selectedButtonIndex.wrappedValue == 1))
                    .frame(maxWidth: .infinity)

                    Button("المرتفعة") {
                        selectedButtonIndex.wrappedValue = 2 // Button 2 selected
                    }
                    .buttonStyle(RERPrimaryButtonStyle(isSelected: selectedButtonIndex.wrappedValue == 2))
                    .frame(maxWidth: .infinity)

                    Button(action: {
                        onExpandTapped()
                        expandList.wrappedValue.toggle()
                    }) {
                        Image(expandList.wrappedValue == true ? "selectedExpand" : "Expand")
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .frame(height: 50)

                PercentageList()
                .frame(height: expandList.wrappedValue ? 400 : 250)
            }

        case .third:
            VStack(spacing: 10) {
//                List(20..<30, id: \.self) { index in
//                    Text(index.description)
//                }
//                .listStyle(.plain)
                PercentageList()
                .frame(maxHeight: .infinity) // This ensures the List expands to show all items
            }
        }
    }
}

struct SwappablePagesView: View {
    @State private var selectedIndex: Int = 0
    @State private var isExpanded = false
    @State private var selectedButtonIndex: Int? = 1

    var onExpandTapped: (() -> Void)? // 👈 Closure prop

    var containerHeight: CGFloat {
        50 + (isExpanded ? 400 : 250)
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedIndex) {
                ForEach(Array(Page.allCases.enumerated()), id: \.offset) { index, page in
                    page.view(
                        expandList: $isExpanded,
                        selectedButtonIndex: $selectedButtonIndex,
                        onExpandTapped: {
                            onExpandTapped?() // 👈 Call the closure
                        }
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: containerHeight)

            Spacer().frame(height: 10)

            HStack(spacing: 4) {
                ForEach(0..<Page.allCases.count, id: \.self) { index in
                    Rectangle()
                        .fill(index == selectedIndex ? Color.alert : Color.invert)
                        .frame(width: 56.0, height: 3)
                        .cornerRadius(2)
                        .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                }
            }
            .padding(.horizontal)
        }
    }
}



import SwiftUI

struct StockRowView: View {
    var title: String
    var price: String
    var percentage: String
    var isFavorite: Bool

    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Text(percentage)
                    .foregroundColor(Color.support)
                    .font(.RERBody.meduim)
                Text("|")
                    .foregroundColor(Color.invert)
                Text(price)
                    .foregroundColor(Color.main)
                    .font(.RERBody.meduim)
            }
            Spacer()

            // Title
            Text(title)
                .foregroundColor(Color.surface)
                .font(.RERBody.meduim)

            // Star icon
            Image(isFavorite ? "star" : "unStar")
        }
        .padding(.vertical, 8)
        .background(Color.black)
    }
}

struct PercentageList: View {
    var body: some View {
        List {
            ForEach(0..<6, id: \.self) { _ in
                StockRowView(title: "عنوان", price: "888.88", percentage: "30.00%", isFavorite: false)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)) 
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 4)
                    .background(Color.black)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
