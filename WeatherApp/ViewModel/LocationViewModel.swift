//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Tushar Sonawane on 07/09/20.
//  Copyright © 2020 Tushar Sonawane. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import UIKit


class LocationViewModel: NSObject {
    
    var currentCoord : ((_ data: Coord) -> Void)?
    var pushWithCoord : ((_ data: Coord) -> Void)?
    private let locationManager = CLLocationManager()
    
    override init() {
      super.init()
      self.locationManager.delegate = self
      self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
      self.locationManager.requestWhenInUseAuthorization()
      self.locationManager.startUpdatingLocation()
    }
}


extension LocationViewModel: CLLocationManagerDelegate {
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("------ \(location)")
        currentCoord?(Coord.init(lon: location.coordinate.longitude , lat: location.coordinate.latitude))
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error \(error)")
    }
}

extension LocationViewModel : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        print(view.annotation?.coordinate ?? "")
        pushWithCoord?(Coord.init(lon: view.annotation?.coordinate.longitude , lat: view.annotation?.coordinate.latitude))
    }
}
