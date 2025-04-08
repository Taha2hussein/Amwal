//
//  SearchBarView.swift
//  RER
//
//  Created by sara alhammad on 16/07/2023.
//

import SwiftUI
import Combine

struct SearchBarView: View {
    @Binding var searchText : String
    var placeholder : String = "search"
    var isNumber: Bool = false
    var showSideImage: Bool = true
    var showXImage: Bool = true
    var dynamicHieght: Bool = false
    var isSubmitLabelEnabled: Bool = false
    var submitLabelType: SubmitLabel = .done
//    var isFirstResponder: Bool = false
    var onSubmit: (() -> ())? = nil
    
    var body: some View {
        HStack {
            if showSideImage{
                Image(systemName: "magnifyingglass").foregroundColor(Color.RERtext.disabled)
            }
            VStack{
                if dynamicHieght {
                    
                    if #available(iOS 16.0, *) {
                        TextField(placeholder, text: $searchText, axis: .vertical)
                            .foregroundColor(.RERtext.primary).font(.RERBody.regular)
                    } else {
                        // Fallback on earlier versions
                    }
                }else{
                    TextField(placeholder, text: $searchText)
                        .foregroundColor(.RERtext.primary).font(.RERBody.regular)
                        .frame(height: 12)
                }
            }
                .overlay(
                    HStack{
                    Spacer()
                    Button{
                        searchText = ""
                    }label: {
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 10)
                            .foregroundColor(Color.RERtext.disabled)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .hidden(!showXImage)
                    }
                    }  )
                .if(isNumber) { view in
                    view.onReceive(Just(searchText)) { newString in
                        let filtered = newString.filter { "0123456789".contains($0) }
                        if filtered != newString {
                            self.searchText = filtered
                        }
                    }
                    .keyboardType(.numberPad)
                }.if(isSubmitLabelEnabled) { view in
                    view.submitLabel(submitLabelType)
                    .onSubmit {
                        guard !searchText.isEmpty else { return }
                        onSubmit?()
                    }
                }
                
            
        }
        .font(.RERBody.regular)
        .padding()
        .background(Color.primary)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.clear, lineWidth: 1)
        ).onChange(of: searchText) { newValue in
            if searchText.count > 0 && searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                searchText = ""
            }
        }
//        .padding(.Spacing.xs)

    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
