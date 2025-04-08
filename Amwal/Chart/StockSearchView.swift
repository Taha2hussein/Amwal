//
//  StockSearchView.swift
//  Amwal
//
//  Created by Taha Hussein on 08/04/2025.
//

import Foundation
import SwiftUI

struct StockItem: Identifiable {
    let id = UUID()
    let name: String
    let code: String
    let percentage: String
    let price1: String
    let price2: String
    let isFavorite: Bool
}
struct StockSearchView: View {
    @State private var searchText: String = ""
    @Binding var isExpanded: Bool
    let stocks: [StockItem] = Array(repeating: StockItem(name: "سابك", code: "2250", percentage: "30.00%", price1: "888.88", price2: "46.3", isFavorite: false), count: 12)
    
    var body: some View {
        VStack(spacing: 0) {
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
//            .padding(.vertical)
            TopSearchField(searchText: $searchText)
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(stocks) { stock in
                        VStack(spacing: 0) {
                            HStack {
                                Image(stock.isFavorite ? "star" : "unStar")
                                    .foregroundColor(stock.isFavorite ? .yellow : .gray)
                                    .imageScale(.small)
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(stock.name)
                                        .foregroundColor(Color.surface)
                                        .font(.RERTitles.title3)
                                    
                                    Text(stock.code)
                                        .foregroundColor(Color.surface)
                                        .font(.RERTitles.title3)
                                }
                                
                                Spacer()
                                VStack(spacing: 6) {
                                    HStack(spacing: 8) {
                                       
                                        Text(stock.price1)
                                            .foregroundColor(Color.main)
                                            .font(.RERBody.meduim)
                                        
                                        Text(stock.percentage)
                                            .foregroundColor(Color.info)
                                            .font(.RERBody.meduim)
                                    }

                                    HStack(spacing: 6) {
                                        // Left value: transparent → green (right to left)
                                        // Right value: red → transparent (right to left)
                                        Text("46.3")
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
                                        HStack(spacing: 0){
                                            Text("|")
                                                .foregroundStyle(Color.main)
                                            
                                            Text("72.6")
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
            }
            .environment(\.layoutDirection, .rightToLeft) // RTL layout
            
        }
        .background(Color.warning)
        .cornerRadius(20)
    }
}
