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
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("11,931.70")
                            .font(.RERTitles.title1)
                            .foregroundStyle(Color.actionDisabled)
                        
                        HStack(spacing: 5) {
                            Text(viewModel.percentage)
                                .font(.RERBody.meduim)
                                .foregroundStyle(Color.support)
                            Text("اليوم -")
                                .font(.RERBody.meduim)
                                .foregroundStyle(Color.actionPressed)
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        SwipeableHeaderView(selectedIndex: viewModel.$selectedIndex)
                        Text(viewModel.opened)
                            .font(.RERBody.meduim)
                            .foregroundStyle(Color.actionPressed)
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Spacer()
                    Text("\(viewModel.highestValue)")
                        .foregroundColor(viewModel.chartColorValue)
                        .font(.RERBody.regular)
                        .padding(.top, 10)
                        .padding(.horizontal)
                }
                
                StockChartView(viewModel: viewModel)
                
                HStack {
                    Spacer()
                    Text("\(viewModel.lowestValue)")
                        .foregroundColor(viewModel.chartColorValue)
                        .font(.RERBody.regular)
                        .padding(.top, 10)
                        .padding(.horizontal)
                }
                
                VStack {
                    TimeLabelsView(labels: viewModel.timeRangeList)
                    TimeRangeOptionsView(viewModel: viewModel)
                    SwappablePagesView {
                        bottomSheetShown.toggle()
                    }
                    Spacer()
                }
            }
            VStack(spacing: 30) {
                NewsOverlayHomeView(isOpened: $bottomSheetShown, isExpanded: $isExpanded)
                if !isExpanded {
                    BottomSearchField(searchText: $searchText) {
                        showSearchView = true
                    }
                    
                }
            }
            DraggableSheetView(isPresented: $showSearchView) {
                StockSearchView() // No dismiss needed — swipe to close
            }
        }
       
        .onAppear {
            viewModel.updateTimeRangeList()
        }
    }
}

