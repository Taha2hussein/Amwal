//
//  SwappableViewsWithIndicator.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import SwiftUI

struct StockRowView: View {
    var title: String
    var price: String
    var percentage: String
    var percentageColor: Color = .green
    @State var isFavorite: Bool = false

    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Text(percentage)
                    .foregroundColor(percentageColor)
                    .font(.RERBody.meduim)
                Text("|")
                    .foregroundColor(Color.invert)
                Text(price)
                    .foregroundColor(Color.main)
                    .font(.RERBody.meduim)
            }

            Spacer()

            Text(title)
                .foregroundColor(Color.surface)
                .font(.RERBody.meduim)

            Button(action: {
                self.isFavorite.toggle()
            }) {
                Image(isFavorite ? "star" : "unStar")
            }
            .buttonStyle(.plain)
        }
    }
}


enum Page: Int, CaseIterable {
    case first, second, third
    
    @ViewBuilder
    func view(
        expandList: Binding<Bool>,
        selectedButtonIndex: Binding<Int?>,
        onExpandTapped: @escaping () -> Void,
        movers: TopMveriesResponse?,
        securities: [SecuritesFilterResponseElement],
        isLoading: Bool
    ) -> some View {
        switch self {
        case .first:
            VStack(spacing: 10) {
                HStack(spacing: 8) {
                    Button("جميع الأسهم") {
                        selectedButtonIndex.wrappedValue = 1
                    }
                    .buttonStyle(RERPrimaryButtonStyle(isSelected: selectedButtonIndex.wrappedValue == 1))
                    
                    Button("المحفظة") {
                        selectedButtonIndex.wrappedValue = 2
                    }
                    .buttonStyle(RERPrimaryButtonStyle(isSelected: selectedButtonIndex.wrappedValue == 2))
                    
                    Button(action: {
                        onExpandTapped()
                        expandList.wrappedValue.toggle()
                    }) {
                        Image(expandList.wrappedValue ? "selectedExpand" : "Expand")
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .frame(height: 50)
                
                if isLoading {
                    Text("Loading...")
                        .frame(width: UIScreen.main.bounds.width, height: expandList.wrappedValue ? (securities.count >= 9 ? 400 : 300) : 250)
                        .background(Color.warning)
                        .foregroundColor(.white)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                } else {
                    // Once data is loaded, show the appropriate content
                    if selectedButtonIndex.wrappedValue == 1 {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(securities.indices, id: \.self) { index in
                                    let item = securities[index]
                                    let changeValue = item.change ?? 0.0
                                    StockRowView(
                                        title: item.name_short_ar ?? "",
                                        price: String(format: "%.2f", item.price ?? 0.0),
                                        percentage: String(format: "%.2f%%", changeValue),
                                        percentageColor: changeValue < 0 ? Color.info : Color.support
                        
                                    )
                                }
                            }
                            .padding()
                        }
                        .background(Color.warning)
                        .frame(height: expandList.wrappedValue ? (securities.count >= 9 ? 400 : 300) : 250)
                    } else {
                        // Placeholder for other conditions
                        Text("")
                            .background(Color.warning)
                            .frame(width: UIScreen.main.bounds.width, height: expandList.wrappedValue ? (securities.count >= 9 ? 400 : 300) : 250)
                    }
                }
            }
            
            
        case .second:
            let selectedList: [Gainer] = {
                if selectedButtonIndex.wrappedValue == 2 {
                    return movers?.gainers ?? []
                } else {
                    return movers?.losers ?? []
                }
            }()
            
            VStack(spacing: 10) {
                HStack(spacing: 8) {
                    Button("المنخفضة") {
                        selectedButtonIndex.wrappedValue = 1
                    }
                    .buttonStyle(RERPrimaryButtonStyle(isSelected: selectedButtonIndex.wrappedValue == 1))
                    .frame(maxWidth: .infinity)
                    
                    Button("المرتفعة") {
                        selectedButtonIndex.wrappedValue = 2
                    }
                    .buttonStyle(RERPrimaryButtonStyle(isSelected: selectedButtonIndex.wrappedValue == 2))
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        onExpandTapped()
                        expandList.wrappedValue.toggle()
                    }) {
                        Image(expandList.wrappedValue ? "selectedExpand" : "Expand")
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .frame(height: 50)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(selectedList.indices, id: \.self) { index in
                            let item = selectedList[index]
                            StockRowView(
                                title: item.name ?? "",
                                price: String(format: "%.2f", item.price ?? 0.0),
                                percentage: String(format: "%.2f%%", item.change ?? 0.0)
                            )
                        }
                    }.padding()
                }
                .frame(height: expandList.wrappedValue ? (selectedList.count >= 9 ? 400 : 300) : 250)
                .background(Color.warning)
            }
            
        case .third:
            StockStatsView()
                .background(Color.gray.opacity(0.2))
            
        }
        
    }
}

struct SwappablePagesView: View {
    @State private var selectedIndex: Int = 0
    @State private var isExpanded = false
    @State private var selectedButtonIndex: Int? = 1
    var movers: TopMveriesResponse?
    var securities: [SecuritesFilterResponseElement]
    var isLoading: Bool
    var onExpandTapped: (() -> Void)?
    
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
                            onExpandTapped?()
                        },
                        movers: movers,
                        securities: securities, isLoading: isLoading
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
