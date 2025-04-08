//
//  CountryCodePicker.swift
//  Dawak
//
//  Created by Taha Hussein on 26/02/2025.
//

import SwiftUI
struct CountryCodePicker: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCountry: Country
    @ObservedObject var viewModel = CountryViewModel()
    @State private var searchText = ""

    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.dialCode.contains(searchText)
            }
        }
    }

    var body: some View {
        VStack {
            // Search bar
            TextField("Search Country", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.top, 20)
            List(filteredCountries) { country in
                HStack {
                    Text(country.flag)
                        .font(.largeTitle)
                    Text(country.name)
                    Spacer()
                    Text(country.dialCode)
                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCountry = country
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
