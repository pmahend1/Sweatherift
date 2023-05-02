//
//  TemperatureConverter.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

struct Converter {
   static func toLocaleTemperature(_ temperature: Double) -> String {
      let formatter = MeasurementFormatter()
      formatter.locale = .current
      formatter.numberFormatter.maximumFractionDigits = 0
      let input = Measurement(value: temperature, unit: UnitTemperature.kelvin)
      return formatter.string(from: input)
   }
}
