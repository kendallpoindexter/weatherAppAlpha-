//
//  WeatherModel.swift
//  weatherAppAlpha
//
//  Created by Kendall Poindexter on 5/25/20.
//  Copyright © 2020 Kendall Poindexter. All rights reserved.
//

import Foundation

struct WeatherForcastData: Decodable, Hashable {
    let list: [WeatherForcast]
}

struct WeatherForcast: Decodable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(day)
    }
    static func == (lhs: WeatherForcast, rhs: WeatherForcast) -> Bool {
        lhs.day == rhs.day
    }
    
    let day: Double
    let main: Main
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case day = "dt"
        case main
        case weather
    }
}

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let lowTemp: Double
    let highTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case lowTemp = "temp_min"
        case highTemp = "temp_max"
    }
}
