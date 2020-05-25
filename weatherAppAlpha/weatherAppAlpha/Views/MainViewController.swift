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
    @IBOutlet weak var dailyForcastTableView: UITableView!
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.locationManager.delegate = self
        viewModel.requestUserLocation()
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        viewModel.lat = location?.coordinate.latitude
        viewModel.lon = location?.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Alert pop up
        print(error)
    }
}
