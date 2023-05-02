//
//  InjectedValues.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

struct InjectedValues {
   private static var current = InjectedValues()

   static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
      get { key.currentValue }
      set { key.currentValue = newValue }
   }

   static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
      get { current[keyPath: keyPath] }
      set { current[keyPath: keyPath] = newValue }
   }
}

extension InjectedValues {
   var RESTService: RESTProtocol {
      get { Self[RESTServiceKey.self] }
      set { Self[RESTServiceKey.self] = newValue }
   }
}

extension InjectedValues {
   var analytics: AnalyticsProtocol {
      get { Self[AnalyticsServiceKey.self] }
      set { Self[AnalyticsServiceKey.self] = newValue }
   }
}

extension InjectedValues {
   var weatherRepository: WeatherRepositoryProtocol {
      get { Self[WeatherRepositoryKey.self] }
      set { Self[WeatherRepositoryKey.self] = newValue }
   }
}

extension InjectedValues {
   var weatherAPIService: WeatherAPIProtocol {
      get { Self[WeatherAPIServiceKey.self] }
      set { Self[WeatherAPIServiceKey.self] = newValue }
   }
}
