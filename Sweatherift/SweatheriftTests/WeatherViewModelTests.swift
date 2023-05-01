//
//  WeatherViewModelTests.swift
//  SweatheriftTests
//
//  Created by Prateek Mahendrakar on 5/1/23.
//

@testable import Sweatherift
import XCTest
import CoreLocation

@MainActor
final class WeatherViewModelTests: XCTestCase {
   var viewModel: WeatherViewModel!
   var RESTServiceMockInstance: RESTServiceMock!
   var analyticsMock: AnaltyicsServiceMock!
   
   override func setUp() {
      viewModel = WeatherViewModel(for: Location(name: "Charlotte", lat: 40.0, lon: 40.0, country: "US", state: "NC"))
      RESTServiceMockInstance = RESTServiceMock()
      analyticsMock = AnaltyicsServiceMock()
      InjectedValues[\.analytics] = analyticsMock
   }

   override func tearDown() {
      viewModel = nil
      RESTServiceMockInstance = nil
      analyticsMock = nil
      InjectedValues[\.analytics] = AnalyticsService()
   }
   
   func testInitWithLocationSucceeds()  {
      viewModel = WeatherViewModel(for: Location(name: "Charlotte", lat: 40.0, lon: 40.0, country: "US", state: "NC"))
      XCTAssertNotNil(viewModel.location)
      XCTAssertNil(viewModel.coOrdinates)
   }
   
   func testInitWithCoOrdinatesSucceeds()  {
      let coOrd = CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)
      viewModel = WeatherViewModel(for: coOrd)
      XCTAssertNil(viewModel.location)
      XCTAssertNotNil(viewModel.coOrdinates)
   }
   
   func test_getWeather_succeeds() async {
      let weatherMock = WeatherMockFactory.makeWeatherReportByLatLon()
      RESTServiceMockInstance.returnableObject = weatherMock
      InjectedValues[\.RESTService] = RESTServiceMockInstance
      await viewModel.getWeather()
      XCTAssertNotNil(viewModel.weatherReport)
   }
   
   func test_getWeather_handlesError() async {
      RESTServiceMockInstance.shouldError = true
      InjectedValues[\.RESTService] = RESTServiceMockInstance
      await viewModel.getWeather()
      XCTAssertNil(viewModel.weatherReport)
      XCTAssertTrue(analyticsMock.wasLogErrorCalled)
   }

}
