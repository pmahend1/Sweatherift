//
//  HomeViewModelTests.swift
//  SweatheriftTests
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

@testable import Sweatherift
import XCTest

final class HomeViewModelTests: XCTestCase {
   var viewModel: HomeViewModel!
   var RESTServiceMockInstance: RESTServiceMock!
   var analyticsMock: AnaltyicsServiceMock!

    @MainActor override func setUp() {
      viewModel = HomeViewModel()
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

   func test_getLocationsHandlesError() async {
      RESTServiceMockInstance.shouldError = true
      InjectedValues[\.RESTService] = RESTServiceMockInstance

      await viewModel.getLocations(searchText: "London,UK")

      XCTAssertTrue(analyticsMock.wasLogErrorCalled)
   }

    /*
   func test_getLocationsSucceeds() async {
      let locationsMock = WeatherMockFactory.makeLocations(searchTerm: "any")
      RESTServiceMockInstance.returnableObject = locationsMock
      InjectedValues[\.RESTService] = RESTServiceMockInstance

      await viewModel.getLocations(searchText: "London,UK")

      XCTAssertFalse(analyticsMock.wasLogErrorCalled)
      XCTAssertTrue(viewModel.locationResults.count > 0)
   }*/
}
