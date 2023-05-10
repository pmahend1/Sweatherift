//
//  RESTServiceKey.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

struct RESTServiceKey: InjectionKey {
   static var currentValue: RESTProtocol = RESTService()
}

struct AnalyticsServiceKey: InjectionKey {
   static var currentValue: AnalyticsProtocol = AnalyticsService()
}

struct WeatherRepositoryKey: InjectionKey {
   static var currentValue: WeatherRepositoryProtocol = WeatherRepository()
}

struct WeatherAPIServiceKey: InjectionKey {
   static var currentValue: WeatherAPIProtocol = WeatherAPIService()
}

struct KeyChainServiceKey: InjectionKey {
   static var currentValue: KeyChainProtocol = KeyChainService.standard
}
