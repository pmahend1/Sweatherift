//
//  HomeView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    // mar
    var body: some View {
        // NavigationView {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Enter City")
                .font(.caption)
                .padding(.leading, 5)
            TextField("Enter City", text: $viewModel.cityName)
                .textFieldStyle(.roundedBorder)
                .padding(.top, 5)

            Button("Search") {
                Task { @MainActor in
                    await viewModel.getWeather(location: "London,UK")
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)

            Spacer()
        }
        .padding()
        .navigationTitle("Sweatherift")
        // }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
