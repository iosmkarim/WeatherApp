//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> Weather
}

struct WeatherService: WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> Weather {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=af1d69240b284e9096d151352241612&q=\(encodedCity)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw URLError(.badServerResponse)
        }

        if let dataString = String(data: data, encoding: .utf8) {
            print(dataString)
        }

        do {
            let weatherResponse = try JSONDecoder().decode(Weather.self, from: data)
            return weatherResponse
        } catch {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Failed to decode weather data"))
        }
    }
}

