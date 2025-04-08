//
//  NewsList.swift
//  Amwal
//
//  Created by Taha Hussein on 08/04/2025.
//

import SwiftUI

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let time: String
    let percentage: String?
    let source: String?
}

struct NewsOverlayHomeView: View {
    @Binding var isOpened: Bool
    @Binding var isExpanded: Bool
    @State private var dragOffset: CGFloat = 0
    @State private var currentOffset: CGFloat = UIScreen.main.bounds.height * 0.68
//    @State private var isExpanded = false
    @State private var searchText: String = ""
    @State private var selectedTab: String = "المحفظة"

    let tabs = ["المحفظة", "الرئيسية", "نمو"]

    let newsItems: [NewsItem] = [
        NewsItem(title: "موافقة الهيئة على طلب شركة المجموعة المتحدة للتأمين التعاوني زيادة رأس مالها عن طريق طرح أسهم حقوق أولوية", time: "12:30PM", percentage: "4.65%", source: "المتحدة"),
        NewsItem(title: "إعلان من هيئة السوق المالية بشأن الموافقة على تسجيل وطرح أسهم شركة ناف للعلف للصناعة في السوق الموازية", time: "12:30PM", percentage: "30.00%", source: "ناف")
    ]

    var filteredNews: [NewsItem] {
        if searchText.isEmpty {
            return newsItems
        } else {
            return newsItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        let hiddenOffset = UIScreen.main.bounds.height

        ZStack(alignment: .top) {
            // Background

            // Bottom sheet
            VStack(spacing: 0) {
                // Drag handle
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 36, height: 4)
                    .padding(.top, 8)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation.height
                            }
                            .onEnded { value in
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                    if value.translation.height < -100 {
                                        currentOffset = 60
                                        isExpanded = true
                                    } else {
                                        currentOffset = UIScreen.main.bounds.height * 0.68
                                        isExpanded = false
                                    }
                                    dragOffset = 0
                                }
                            }
                    )

                if isExpanded {
                    HStack {
                        Button(action: {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                currentOffset = UIScreen.main.bounds.height * 0.68
                                isExpanded = false
                            }
                        }) {
                            Image("Close")
                                .foregroundColor(.white)
                                .padding(8)
                                .clipShape(Circle())
                        }
                        Spacer()
                        HStack {
                            ForEach(tabs, id: \.self) { tab in
                                Button(action: {
                                    selectedTab = tab
                                }) {
                                    Text(tab)
                                        .font(.RERBody.meduim)
                                        .foregroundColor(selectedTab == tab ? Color.actionDisabled : Color.main)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }

                // Search Field (Always shown inside sheet)
                if isExpanded {
                    TopSearchField(searchText: $searchText)
                }
                
                // News List
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(filteredNews) { item in
                            VStack(alignment: .trailing, spacing: 6) {
                                Text(item.title)
                                    .font(.RERBody.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)

                                HStack {
                                    if let percentage = item.percentage, let source = item.source {
                                        HStack(spacing: 4) {
                                            Text(source)
                                                .font(.RERBody.regular)
                                                .foregroundColor(Color.actionDisabled)

                                            Text(percentage)
                                                .font(.RERBody.regular)
                                                .foregroundColor(Color.main)
                                        }
                                    }
                                    Spacer()
                                    Text(item.time)
                                        .font(.RERBody.regular)
                                        .foregroundColor(Color.success)
                                }
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            Divider()
                                .background(Color.gray.opacity(0.2))
                                .padding(.horizontal, 16)
                        }
                        Spacer(minLength: 80)
                    }
                    .environment(\.layoutDirection, .rightToLeft)
                }
               
            }
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(20)
            .offset(y: isOpened ? currentOffset + dragOffset : hiddenOffset)
            .animation(.easeInOut, value: isOpened)
            .animation(.easeInOut, value: currentOffset + dragOffset)
        }
    }
}

struct BottomSearchField: View {
    @Binding var searchText: String
    var onTap: () -> Void

    var body: some View {
        HStack {
            Image("Search Glyph")
                .foregroundColor(Color.main)

            Text("بحث")
                .foregroundColor(Color.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .padding(12)
        .background(Color.warning)
        .cornerRadius(12)
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            print("Tapped search field")
            onTap()
        }
    }
}

struct TopSearchField: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image("Search Glyph")
                .foregroundColor(Color.main)
            TextField("بحث", text: $searchText)
                .foregroundColor(Color.white)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .padding(12)
        .background(Color.warning)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
