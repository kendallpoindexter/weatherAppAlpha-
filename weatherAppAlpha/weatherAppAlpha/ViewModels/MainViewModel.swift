//
//  MainViewModel.swift
//  weatherAppAlpha
//
//  Created by Kendall Poindexter on 5/25/20.
//  Copyright © 2020 Kendall Poindexter. All rights reserved.
//

import CoreLocation

class MainViewModel {
    let locationManager = CLLocationManager()
    var lat: Double?
    var lon: Double?
    
    func requestUserLocation() {
        requestUserAuthorization {
            locationManager.requestLocation()
        }
    }
    
    private func requestUserAuthorization(completion: () -> Void) {
        locationManager.requestWhenInUseAuthorization()
        completion()
    }
}
