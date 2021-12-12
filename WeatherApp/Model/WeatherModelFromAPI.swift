//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Fazlik Ziyaev on 11/09/21.
//

import UIKit

struct WeatherModelFromAPI : Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let temp_max: Double
    let temp_min: Double
}

struct Weather: Codable {
    let description: String
}
