//
//  CountryViewModel.swift
//  Dawak
//
//  Created by Taha Hussein on 26/02/2025.
//

import SwiftUI
class CountryViewModel: ObservableObject {
    @Published var countries: [Country] = []

    init() {
        loadCountries()
    }

    private func loadCountries() {
        if let url = Bundle.main.url(forResource: "countries", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode([Country].self, from: data)
                countries = decodedData
            } catch {
                print("Error loading countries: \(error)")
            }
        }
    }
}
