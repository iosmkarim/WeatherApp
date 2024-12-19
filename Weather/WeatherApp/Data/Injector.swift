//
//  Injector.swift
//  WeatherApp
//
//  Created by Md Rezaul Karima on 12/16/24.
//

import Foundation

class Injector {
    static let shared = Injector()

    // Configuration for services
    var weatherService: WeatherServiceProtocol

    private init() {
        self.weatherService = WeatherService()
    }

    func setWeatherService(_ service: WeatherServiceProtocol) {
        self.weatherService = service
    }
}
