//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import SwiftUI

struct WeatherView: View {
    @AppStorage("savedCity") private var savedCity: String = ""
    @State private var isLoading = true
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                if let weather = viewModel.weather {
                    VStack {
                        Spacer()
                        HomeView(weather: weather)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            fetchWeatherData()
        }
    }

    private func fetchWeatherData() {
        Task {
            await viewModel.searchCity(savedCity)
            isLoading = false
        }
    }
}

#Preview {
    WeatherView()
}
