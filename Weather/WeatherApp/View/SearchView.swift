//
//  SearchView.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText: String = ""
    @AppStorage("savedCity") private var savedCity: String = ""
    
    @State private var showWeatherView: Bool = false
    @State private var showEmptyView: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            // Search Bar
            HStack {
                TextField("Search Location", text: $searchText)
                    .padding(.leading)
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            viewModel.weather = nil
                            UserDefaults.standard.removeObject(forKey: "savedCity")
                            await viewModel.searchCity(searchText)
                            showWeatherView = false
                            showEmptyView = searchText == "" ? true : false
                        }
                    }
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding()
            }
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Search Result
            if !showWeatherView {
                
                if showEmptyView {
                    
                    EmptyView()
                    
                } else {
                    
                    if let weather = viewModel.weather {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(weather.location.name)
                                    .font(.title3)
                                    .bold()
                                Text("\(Int(weather.current.temp_c))°")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            // Weather Icon
                            if !weather.current.condition.icon.isEmpty {
                                AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding()
                        .onTapGesture {
                            // Save the city name in UserDefaults
                            savedCity = searchText
                            showWeatherView = true
                            showEmptyView = false
                        }
                    }
                }
            } else {
                WeatherView()
            }
            
            Spacer()
        }.onAppear {
            showEmptyView = true
        }
    }
}

#Preview {
    SearchView()
}
