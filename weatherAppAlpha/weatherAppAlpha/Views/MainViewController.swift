//
//  ViewController.swift
//  weatherAppAlpha
//
//  Created by Kendall Poindexter on 5/24/20.
//  Copyright © 2020 Kendall Poindexter. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    enum Section {
        case main
    }
    @IBOutlet weak var dailyForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    let viewModel = MainViewModel()
    var dataSource: UITableViewDiffableDataSource<Section, WeatherForcastData>?
    
        override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.locationManager.delegate = self
        viewModel.requestUserLocation()
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: dailyForcastTableView, cellProvider: { (tableView, indexPath, weatherForcast) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "dailyForcastCell", for: indexPath) as? 
        })
    }
    
    private func updateUI(weather: WeatherData) {
        cityNameLabel.text = weather.name
        currentTempLabel.text = String(weather.main.temp)
        lowTempLabel.text = String(weather.main.lowTemp)
        highTempLabel.text = String(weather.main.highTemp)
        weatherDescription.text = weather.weather[0].description
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        guard let latitude = location?.coordinate.latitude, let longitude = location?.coordinate.longitude else { return }
        
        viewModel.getLatAndLon(latitude: latitude, longitude: longitude) {
            viewModel.fetchWeatherData { result in
                switch result {
                case .success(let weatherData):
                    DispatchQueue.main.async {
                        self.updateUI(weather: weatherData)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
            viewModel.fetchWeatherForcastData { result in
                switch result {
                case .success(let weatherForcast):
                    print(weatherForcast)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Alert pop up
        print(error)
    }
}


