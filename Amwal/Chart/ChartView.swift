//
//  StocksView.swift
//  Amwal
//
//  Created by Taha Hussein on 07/04/2025.
//

import SwiftUI
import Charts

struct StocksView: View {
    @StateObject private var viewModel = StocksViewModel()
    @State var bottomSheetShown = true
    @State var searchText: String = ""
    @State private var showSearchView = false
    @State private var isExpanded = false
    @State  var selectedIndex = 0
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(formattedValue(viewModel.openedValue))
                            .font(.RERTitles.title1)
                            .foregroundStyle(Color.actionDisabled)

                            .font(.RERTitles.title1)
                            .foregroundStyle(Color.actionDisabled)
                        
                        HStack(spacing: 5) {
                            Text(String(format: "%.2f", viewModel.latestValue))
                                .font(.RERBody.regular)
                                .foregroundColor(viewModel.latestValue > 0 ? Color.support : Color.info)
                            HStack{
                                
                                Text("(\(viewModel.percentageText))")
                                    .font(.RERBody.regular)
                                    .foregroundColor(viewModel.percentageText > "0" ? Color.support : Color.info)
                                
                                Text("اليوم - ")
                                    .font(.RERBody.regular)
                                    .foregroundStyle(Color.actionPressed)
                            }
                        }
                    }.padding(.horizontal, 10)
                    Spacer()
                    VStack(alignment: .trailing) {
                        SwipeableHeaderView(selectedIndex: $selectedIndex)
                        Text(viewModel.opened)
                            .font(.RERBody.meduim)
                            .foregroundStyle(Color.actionDisabled)
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Spacer()
                    Text(String(format: "%.2f", viewModel.highestValue))
                        .foregroundColor(viewModel.chartColorValue)
                        .font(.RERBody.regular)
                        .padding(.top, 10)
                        .padding(.horizontal)
                }
                
                StockChartView(viewModel: viewModel)
                
                HStack {
                    Spacer()
                    Text(String(format: "%.2f", viewModel.lowestValue))
                        .foregroundColor(viewModel.chartColorValue)
                        .font(.RERBody.regular)
                        .padding(.top, 10)
                        .padding(.horizontal)
                }
                
                VStack {
                    TimeLabelsView(labels: viewModel.timeRangeList)
                    TimeRangeOptionsView(viewModel: viewModel)
                    SwappablePagesView(movers: viewModel.topMoveris, securities: viewModel.securitesFilter ?? [],isLoading: viewModel.isLoading) {
                        bottomSheetShown.toggle()
                    }
                    Spacer()
                }
            }
            VStack(spacing: 30) {
                NewsOverlayHomeView(isOpened: $bottomSheetShown, isExpanded: $isExpanded, announcmentList: viewModel.announcmentList ?? [])
                if !isExpanded {
                    BottomSearchField(searchText: $searchText) {
                        showSearchView = true
                    }
                    
                }
            }
            DraggableSheetView(isPresented: $showSearchView) {
                StockSearchView(isExpanded: $showSearchView,securitesFilter: viewModel.securitesFilter ?? [])

            }
        }
       
        .onAppear {
            viewModel.updateTimeRangeList()
            viewModel.fetchHistoryList()
            viewModel.fetchAnnouncmentsList()
            viewModel.fetchTopMoveriesList()
            viewModel.fetchASecurtitesFilter()
        }
    }
    private func formattedValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "0.00"
    }
}

