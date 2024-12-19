//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var errorMessage: String?
    
    private let weatherService = Injector.shared.weatherService
    
    func fetchWeather(for city: String) async {
        do {
            let weather = try await weatherService.fetchWeather(for: city)
            self.weather = weather
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
