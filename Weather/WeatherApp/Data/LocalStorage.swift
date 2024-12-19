//
//  LocalStorage.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import Foundation

protocol LocalStorageProtocol {
    func saveCity(_ city: String)
    func getCities() -> [String]
}
class LocalStorage {
    private let defaults = UserDefaults.standard

    func saveCity(_ city: String) {
        var cities = getCities()
        if !cities.contains(city) {
            cities.insert(city, at: 0)
            defaults.set(cities, forKey: "searchHistory")
        }
    }

    func getCities() -> [String] {
        defaults.stringArray(forKey: "searchHistory") ?? []
    }
}
