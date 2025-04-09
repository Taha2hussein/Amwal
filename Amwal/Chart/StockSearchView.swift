//
//  StockSearchView.swift
//  Amwal
//
//  Created by Taha Hussein on 08/04/2025.
//

import Foundation
import SwiftUI

struct StockSearchView: View {
    @State private var searchText: String = ""
    @Binding var isExpanded: Bool
    @State var securitesFilter: [SecuritesFilterResponseElement]
    
    @FocusState private var isSearchFieldFocused: Bool

    var filteredStocks: [SecuritesFilterResponseElement] {
        if searchText.isEmpty {
            return securitesFilter
        } else {
            return securitesFilter.filter {
                ($0.name_short_ar ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            headerView

            // Pinned Search Bar
            TopSearchField(searchText: $searchText, isFocused: $isSearchFieldFocused)
                .focused($isSearchFieldFocused)
                .padding(.horizontal)

            Divider()
                .background(Color.white.opacity(0.1))

            // Scrollable Content
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredStocks) { stock in
                        stockRow(for: stock)
                    }
                }
                .padding(.bottom, 16)
            }
            .environment(\.layoutDirection, .rightToLeft)
        }
        .background(Color.warning)
        .cornerRadius(20)
        .ignoresSafeArea(.keyboard) 
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            if isExpanded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isSearchFieldFocused = true
                }
            }
        }
        .onChange(of: isExpanded) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isSearchFieldFocused = true
                }
            }
        }
        .hideKeyboardOnTap()
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            Button(action: {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    isExpanded = false
                }
            }) {
                Image("Close")
                    .foregroundColor(.white)
                    .padding(8)
                    .clipShape(Circle())
            }

            Spacer()

            Text("أداة الفرز")
                .font(.RERTitles.title3)
                .foregroundStyle(Color.lightGray)
        }
        .padding(.horizontal)
        .padding(.top, 12)
    }

    // MARK: - Stock Row
    @ViewBuilder
    private func stockRow(for stock: SecuritesFilterResponseElement) -> some View {
        let price = String(format: "%.2f", stock.price ?? 0.0)
        let low = String(format: "%.2f", stock.low ?? 0.0)
        let high = String(format: "%.2f", stock.high ?? 0.0)

        VStack(spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image("unStar")
                        .foregroundColor(.gray)
                        .imageScale(.small)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(stock.name_short_ar ?? "")
                        .foregroundColor(Color.surface)
                        .font(.RERTitles.title3)
                    Text(stock.ticker ?? "")
                        .foregroundColor(Color.surface)
                        .font(.RERTitles.title3)
                }

                Spacer()

                VStack(spacing: 6) {
                    HStack(spacing: 15) {
                        Text(price)
                            .foregroundColor(Color.main)
                            .font(.RERBody.meduim)

                        Text(String(format: "%.2f%%", low))
                            .foregroundColor(Color.info)
                            .font(.RERBody.meduim)

                    }

                    HStack(spacing: 6) {
                        Text(high)
                            .font(.RERBody.meduim)
                            .foregroundColor(.black)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 12)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.red, Color.red.opacity(0)]),
                                    startPoint: .trailing,
                                    endPoint: .leading
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 6))

                        HStack(spacing: 0) {
                            Text("|")
                                .foregroundStyle(Color.main)

                            Text(low)
                                .font(.RERBody.meduim)
                                .foregroundColor(.black)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 12)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.green.opacity(0), Color.green]),
                                        startPoint: .trailing,
                                        endPoint: .leading
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)

            Divider()
                .background(Color.white.opacity(0.1))
        }
    }
}

