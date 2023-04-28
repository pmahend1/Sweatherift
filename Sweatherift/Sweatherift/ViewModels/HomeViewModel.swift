//
//  HomeViewModel.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    // MARK: - Properties

    @Published var cityName = ""

    // MARK: - Methods

    func getWeather(location: String) async {
        let url = "\(Constants.weatherUrl)\(location)&APPID=\(Constants.weatherAPIKey)"
        let result = await RESTService().get(url: url)
        switch result {
        case .success(let success):
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let data = try jsonDecoder.decode(WeatherReport.self, from: success)
                print(data.id)
            } catch {
                print(String(describing: error))
            }
        case .failure(let failure):
            print(failure)
        }
    }
}
