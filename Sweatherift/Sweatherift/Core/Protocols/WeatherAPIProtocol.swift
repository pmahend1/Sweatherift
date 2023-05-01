//
//  WeatherAPIProtocol.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

protocol WeatherAPIProtocol {
   func getWeatherByLatLon(lat: Double, lon: Double) async-> Result<WeatherReport, Error>
   func getLocationByLatLon(lat: Double, lon: Double) async-> Result<Location, Error>
   func searchLocations(searchTerm: String) async-> Result<[Location], Error>
}
