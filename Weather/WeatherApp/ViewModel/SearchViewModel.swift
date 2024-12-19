//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var searchHistory: [String] = []
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol
    private let localStorage: LocalStorage

    init(weatherService: WeatherServiceProtocol = WeatherService(), localStorage: LocalStorage = LocalStorage()) {
        self.weatherService = weatherService
        self.localStorage = localStorage
        loadSearchHistory()
    }

    func searchCity(_ city: String) async {
        guard !city.isEmpty else { return }
        do {
            let weather = try await weatherService.fetchWeather(for: city)
            self.weather = weather
            addToSearchHistory(city)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }


    private func addToSearchHistory(_ city: String) {
        if !searchHistory.contains(city) {
            searchHistory.insert(city, at: 0)
            localStorage.saveCity(city)
        }
    }

     func loadSearchHistory() {
        searchHistory = localStorage.getCities()
    }
}
