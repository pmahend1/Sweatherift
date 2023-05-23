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
   @Published var hasError = false
   @Published var hasSharedLocation = false
   
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
      if location != nil {
         hasSharedLocation = true
      }
   }

   func locationManager(_: CLLocationManager, didFailWithError error: Error) {
      print(error)
      hasError = true
   }
}

extension CLLocationCoordinate2D: Equatable {
   public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
      lhs.latitude == rhs.latitude && rhs.longitude == rhs.longitude
   }
}
