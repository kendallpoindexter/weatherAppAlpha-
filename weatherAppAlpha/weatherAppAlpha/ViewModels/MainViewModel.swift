//
//  MainViewModel.swift
//  weatherAppAlpha
//
//  Created by Kendall Poindexter on 5/25/20.
//  Copyright © 2020 Kendall Poindexter. All rights reserved.
//

import CoreLocation


class MainViewModel {
    let networkManager = NetworkManager()
    let locationManager = CLLocationManager()
    var lat: Double?
    var lon: Double?
    
    func fetchWeatherForcastData(completion: @escaping (Result<WeatherForcastData,Error>) -> Void) {
        guard let lat = lat, let lon = lon else { return }
        networkManager.fetchWeatherForcastData(with: lat, lon: lon) { (result) in
            switch result {
            case .success(let weatherForcastData):
                completion(.success(weatherForcastData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchWeatherData(completion: @escaping (Result<WeatherData,Error>) -> Void) {
        guard let lat = lat, let lon = lon else { return }
        networkManager.fetchWeatherData(with: lat, lon: lon) { (result) in
            switch result {
            case .success(let weatherData):
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLatAndLon(latitude: Double, longitude: Double, completion: () -> Void) {
        lat = latitude
        lon = longitude
        completion()
    }
    
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
