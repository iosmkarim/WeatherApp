//
//  MockWeatherService.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import Foundation

class MockWeatherService: WeatherServiceProtocol {
    var mockError: Error?
    var mockWeather: Weather?

    func fetchWeather(for city: String) async throws -> Weather {
        if let error = mockError {
            throw error
        }
        guard let weather = mockWeather else {
            throw URLError(.badServerResponse)
        }
        return weather
    }
}
