//
//  HomeView.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import SwiftUI

struct HomeView: View {
    let weather: Weather?
  
    var body: some View {
        if let weather = weather?.current {
            VStack {
                if let iconURL = weather.condition.icon as? String{
                    AsyncImage(url: URL(string: "https:\(iconURL)")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                    } placeholder: {
                        ProgressView()
                    }
                }
                HStack {
                    Text(self.weather?.location.name ?? "Unknown Location").font(.title).bold()
                    Image(systemName: "location.fill")
                }.padding(.vertical, 10)
                HStack(alignment: .top, spacing: 0) {
                    Text("\(Int(weather.temp_c))")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(.black)
                    Text("°")
                        .font(.system(size: 30, weight: .light))
                        .offset(x: 0, y: -10)
                }
                HStack(alignment: .center,spacing: 20) {
                    VStack
                    {
                        Text("Humdinity").font(.subheadline)
                        Text("\(weather.humidity)%")
                    }
                    
                    VStack
                    {
                        Text("UV").font(.subheadline)
                        Text("\(Int(weather.uv))")
                    }
                    VStack {
                        Text("Feels Like")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(Int(weather.feelslike_c))°")
                    }
                }.foregroundStyle(.gray)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    HomeView(weather: nil)
}
