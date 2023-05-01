//
//  WeatherRepositoryProtocol.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

protocol WeatherRepositoryProtocol: Resettable {
   func getWeatherByLatLon(lat: Double, lon: Double, useCache: Bool) async -> Result<WeatherReport, Error>
   func getLocationByLatLon(lat: Double, lon: Double, useCache: Bool) async -> Result<Location, Error>
   func searchLocations(searchTerm: String, useCache: Bool) async -> Result<[Location], Error>
}
