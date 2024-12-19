//
//  EmptyView.swift
//  WeatherApp
//
//  Created by Md Rezaul Karim on 12/16/24.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No City Selected").font(.title2).bold()
            Text("Please search for A city").font(.subheadline)
            Spacer()
        }
    }
}

#Preview {
    EmptyView()
}
