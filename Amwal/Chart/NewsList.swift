//
//  NewsList.swift
//  Amwal
//
//  Created by Taha Hussein on 08/04/2025.
//
import SwiftUI


struct NewsOverlayHomeView: View {
    @Binding var isOpened: Bool
    @Binding var isExpanded: Bool
    @State private var dragOffset: CGFloat = 0
    @State private var currentOffset: CGFloat = UIScreen.main.bounds.height * 0.68
    @State private var searchText: String = ""
    @State private var selectedTab: String = "المحفظة"

    let tabs = ["المحفظة", "الرئيسية", "نمو"]
    var announcmentList: [AnnouncmentResponseElement] 

    var filteredNews: [AnnouncmentResponseElement] {
        let filtered = searchText.isEmpty ?
            announcmentList :
            announcmentList.filter {
                ($0.headline ?? "").localizedCaseInsensitiveContains(searchText)
            }
        
        // Limit to 2 items only if not opened or not expanded
        if !isOpened || !isExpanded {
            return Array(filtered.prefix(2))
        } else {
            return filtered
        }
    }

    var body: some View {
        let hiddenOffset = UIScreen.main.bounds.height
        @FocusState  var isSearchFocused: Bool

        ZStack(alignment: .top) {
            VStack(spacing: 0) {
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

                if isExpanded {
                    TopSearchField(searchText: $searchText, isFocused: $isSearchFocused)
                }

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(filteredNews.indices, id: \.self) { index in
                            let item = filteredNews[index]
                            VStack(alignment: .trailing, spacing: 6) {
                                Text(item.headline ?? "عنوان غير متوفر")
                                    .font(.RERBody.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)

                                HStack {
                                    if let source = item.security?.name {
                                        Text(source)
                                            .font(.RERBody.regular)
                                            .foregroundColor(Color.actionDisabled)
                                    }

                                    if let change = item.security?.change {
                                        Text(formattedPercentage(change))
                                            .font(.RERBody.regular)
                                            .foregroundColor(change > 0 ? Color.support : Color.info)
                                    }

                                    Spacer()

                                    Text(formattedDate(item.date))
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
        }.onAppear {
            isSearchFocused = true
        }.onChange(of: isExpanded) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isSearchFocused = true
                }
            }
        } .hideKeyboardOnTap()
    }

    private func formattedDate(_ dateStr: String?) -> String {
        guard let dateStr = dateStr else { return "تاريخ غير متوفر" }

        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" 

        if let date = inputFormatter.date(from: dateStr) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h:mma"
            outputFormatter.amSymbol = "AM"
            outputFormatter.pmSymbol = "PM"
            return outputFormatter.string(from: date)
        }

        return "تاريخ غير متوفر"
    }


    private func formattedPercentage(_ value: Double?) -> String {
        guard let value = value else { return "" }
        return String(format: "%.2f%%", value)
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
    @FocusState.Binding var isFocused: Bool  

    var body: some View {
        HStack {
            Image("Search Glyph")
                .foregroundColor(Color.main)

            TextField("بحث", text: $searchText)
                .foregroundColor(Color.white)
                .focused($isFocused)  // 👈 Attach focus
        }
        .environment(\.layoutDirection, .rightToLeft)
        .padding(12)
        .background(Color.warning)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

