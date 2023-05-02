//
//  LocationManager.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
   // MARK: - Properties

   let manager = CLLocationManager()

   @Published var location: CLLocationCoordinate2D?

   var hasLocation: Bool {
      return location != nil
   }

   // MARK: - Init

   override init() {
      super.init()
      manager.delegate = self
   }

   // MARK: - Methods

   func requestLocation() {
      manager.requestLocation()
   }

   func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      location = locations.first?.coordinate
   }

   func locationManager(_: CLLocationManager, didFailWithError error: Error) {
      print(error)
   }
}
