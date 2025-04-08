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
//
//struct NewsOverlayHomeView: View {
//    @Binding var isOpened: Bool
//    @State private var dragOffset: CGFloat = 0
//    @State private var currentOffset: CGFloat = UIScreen.main.bounds.height * 0.68
//    @State private var isExpanded = false
//
//    let newsItems: [NewsItem] = [
//        NewsItem(title: "موافقة الهيئة على طلب شركة المجموعة المتحدة للتأمين التعاوني زيادة رأس مالها عن طريق طرح أسهم حقوق أولوية", time: "12:30PM", percentage: "4.65%", source: "المتحدة"),
//        NewsItem(title: "إعلان من هيئة السوق المالية بشأن الموافقة على تسجيل وطرح أسهم شركة ناف للعلف للصناعة في السوق الموازية", time: "12:30PM", percentage: "30.00%", source: "ناف"),
//        NewsItem(title: "تعلن الشركة العربية للاستثمار الزراعي والصناعي عن النتائج المالية السنوية المنتهية في 2024-12-31", time: "12:30PM", percentage: nil, source: nil)
//    ]
//
//    var body: some View {
//        let hiddenOffset = UIScreen.main.bounds.height
//
//        VStack(spacing: 0) {
//            // Drag handle
//            RoundedRectangle(cornerRadius: 2)
//                .fill(Color.gray.opacity(0.5))
//                .frame(width: 36, height: 4)
//                .padding(.top, 8)
//                .gesture(
//                    DragGesture()
//                        .onChanged { value in
//                            dragOffset = value.translation.height
//                        }
//                        .onEnded { value in
//                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
//                                if value.translation.height < -100 {
//                                    currentOffset = 60
//                                    isExpanded = true
//                                } else {
//                                    currentOffset = UIScreen.main.bounds.height * 0.7
//                                    isExpanded = false
//                                }
//                                dragOffset = 0
//                            }
//                        }
//                )
//
//            // List like screenshot
//            ScrollView {
//                VStack(spacing: 0) {
//                    ForEach(newsItems) { item in
//                        VStack(alignment: .trailing, spacing: 6) {
//                            Text(item.title)
//                                .font(.RERBody.bold)
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.trailing)
//
//                            HStack {
//                                if let percentage = item.percentage, let source = item.source {
//                                    HStack(spacing: 4) {
//                                       
//                                        Text(source)
//                                            .font(.RERBody.regular)
//                                            .foregroundColor(Color.actionDisabled)
//                                        
//                                        Text(percentage)
//                                            .font(.RERBody.regular)
//                                            .foregroundColor(Color.main)
//                                    }
//                                }
//                                Spacer()
//                                Text(item.time)
//                                    .font(.RERBody.regular)
//                                    .foregroundColor(Color.success)
//                            }
//                        }
//                        .padding(.vertical, 12)
//                        .padding(.horizontal, 16)
//
//                        Divider()
//                            .background(Color.gray.opacity(0.2))
//                            .padding(.horizontal, 16)
//                    }
//
//                    Spacer(minLength: 80)
//                }
//                .environment(\.layoutDirection, .rightToLeft)
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .background(Color.black)
//        .cornerRadius(20)
//        .offset(y: isOpened ? currentOffset + dragOffset : hiddenOffset)
//        .animation(.easeInOut, value: isOpened)
//        .animation(.easeInOut, value: currentOffset + dragOffset)
//        .ignoresSafeArea(edges: .bottom)
//    }
//}
//
//
//
import SwiftUI

struct NewsOverlayHomeView: View {
    @Binding var isOpened: Bool
    @State private var dragOffset: CGFloat = 0
    @State private var currentOffset: CGFloat = UIScreen.main.bounds.height * 0.68
    @State private var isExpanded = false
    @State private var searchText: String = ""
    @State private var selectedTab: String = "المحفظة"

    let tabs = ["المحفظة", "الرئيسية", "نمو"]

    let newsItems: [NewsItem] = [
        NewsItem(title: "موافقة الهيئة على طلب شركة المجموعة المتحدة للتأمين التعاوني زيادة رأس مالها عن طريق طرح أسهم حقوق أولوية", time: "12:30PM", percentage: "4.65%", source: "المتحدة"),
        NewsItem(title: "إعلان من هيئة السوق المالية بشأن الموافقة على تسجيل وطرح أسهم شركة ناف للعلف للصناعة في السوق الموازية", time: "12:30PM", percentage: "30.00%", source: "ناف"),
        NewsItem(title: "تعلن الشركة العربية للاستثمار الزراعي والصناعي عن النتائج المالية السنوية المنتهية في 2024-12-31", time: "12:30PM", percentage: "30.00%", source: "العربية"),
        NewsItem(title: "إعلان البنك السعودي الفرنسي (بي اس اف) عن توصية مجلس الإدارة بشراء أسهمه", time: "12:30PM", percentage: "4.65%", source: "الفرنسي"),
        NewsItem(title: "اعلان شركة لبن الخبر للتجارة عن النتائج المالية السنوية المنتهية في 2024-12-31", time: "12:30PM", percentage: "4.65%", source: "لبن"),
        NewsItem(title: "تعلن شركة مركز إيداع الأوراق المالية (إيداع) عن نشر مشروع قائمة المصطلحات المستخدمة في قواعد السوق المعدلة", time: "12:30PM", percentage: "4.65%", source: "إيداع"),
        NewsItem(title: "هيئة السوق المالية تستطلع آراء العموم حيال مشروع تحسين حوكمة المنشآت ذات الأغراض الخاصة وتسهيل إجراءاتها", time: "12:30PM", percentage: "4.65%", source: "سابك"),
        NewsItem(title: "أرامكو تستحوذ على سابك", time: "12:30PM", percentage: "4.65%", source: "سابك")
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
                    // X Button on the left
                    Button(action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            currentOffset = UIScreen.main.bounds.height * 0.7
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


                // Search (only when expanded)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("بحث", text: $searchText)
                        .foregroundColor(.white)
                }
                .environment(\.layoutDirection, .rightToLeft)
                .padding(12)
                .background(Color.white.opacity(0.07))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 8)
            }

            // News List (always shown)
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
        .ignoresSafeArea(edges: .bottom)
    }
}
