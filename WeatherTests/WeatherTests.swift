//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Md Rezaul Karim on 12/19/24.
//

import XCTest
@testable import Weather

final class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    var mockWeatherService: MockWeatherService!
    var mockLocalStorage: MockLocalStorage!
    
    @MainActor
    override func setUpWithError() throws {
        mockWeatherService = MockWeatherService()
        mockLocalStorage = MockLocalStorage()
        viewModel = SearchViewModel(weatherService: mockWeatherService, localStorage: mockLocalStorage)
    }
    
    
    override func tearDownWithError() throws {
        Task {
            await MainActor.run {
                self.viewModel = nil
                self.mockWeatherService = nil
                self.mockLocalStorage = nil
            }
        }
    }
    @MainActor
    func testSearchCitySuccess() async throws {
        // Given: Mock weather data
        let mockWeather = Weather(location: Weather.Location(name: "London", region: "London", country: "UK"),
                                  current: Weather.CurrentWeather(temp_c: 15.0, condition: Weather.CurrentWeather.Condition(text: "Clear", icon: "icon_url"),
                                                                  humidity: 80, uv: 5.0, feelslike_c: 14.0))
        mockWeatherService.mockWeather = mockWeather
        print("Test Case: Given mock weather data for London")
        
        // When: Searching for "London"
        await viewModel.searchCity("London")
        print("Test Case: When searchCity is called for London")
        
        // Then: Assert the expected results
        XCTAssertEqual(viewModel.weather?.location.name, "London")
        print("Test Case: Asserted that location is London")
        
        XCTAssertEqual(viewModel.weather?.current.temp_c, 15.0)
        print("Test Case: Asserted that temperature is 15.0")
        
        XCTAssertEqual(viewModel.searchHistory.first, "London")
        print("Test Case: Asserted that search history first element is London")
    }
    @MainActor
    func testSearchCityFailure() async throws {
        // Given
        mockWeatherService.mockError = URLError(.notConnectedToInternet)
        
        // When
        await viewModel.searchCity("UnknownCity")
        
        // Then
        XCTAssertNil(viewModel.weather)
        XCTAssertEqual(viewModel.errorMessage, URLError(.notConnectedToInternet).localizedDescription)
        
    }
    
    @MainActor
    func testSearchHistoryIsSaved() async throws {
        // Given
        let mockWeather = Weather(location: Weather.Location(name: "Paris", region: "Paris", country: "France"),
                                  current: Weather.CurrentWeather(temp_c: 18.0, condition: Weather.CurrentWeather.Condition(text: "Sunny", icon: "icon_url"),
                                                                  humidity: 65, uv: 3.0, feelslike_c: 17.0))
        mockWeatherService.mockWeather = mockWeather
        
        // When
        await viewModel.searchCity("Paris")
        
        // Then
        XCTAssertTrue(mockLocalStorage.cities.contains("Paris"))
    }
    
    
    func testLoadSearchHistory() async {
        // Given
        mockLocalStorage.cities = ["New York", "Berlin", "Tokyo"]
        
        // When
        await MainActor.run {
            viewModel.loadSearchHistory()
        }
        
        // Then
        await MainActor.run {
            XCTAssertEqual(viewModel.searchHistory, ["New York", "Berlin", "Tokyo"])
        }
    }
}

