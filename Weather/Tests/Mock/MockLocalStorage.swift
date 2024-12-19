//
//  MockLocalStorage.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import Foundation
class MockLocalStorage: LocalStorage {
    var cities: [String] = []

    override func saveCity(_ city: String) {
        cities.append(city)
    }

    override func getCities() -> [String] {
        return cities
    }
}
