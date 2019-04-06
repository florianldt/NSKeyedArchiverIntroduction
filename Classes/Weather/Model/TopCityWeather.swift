//
//  TopCityWeather.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 3/26/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct TopCityWeather: Codable {
    let Key: String
    let LocalizedName: String
    let EnglishName: String
    let WeatherText: String
    let WeatherIcon: Int
    let IsDayTime: Bool
    let Country: Country
    let Temperature: Temperature
}

struct Country: Codable {
    let ID: String
    let LocalizedName: String
    let EnglishName: String
}

struct Temperature: Codable {
    let Metric: TemperatureParameters
    let Imperial: TemperatureParameters
}

struct TemperatureParameters: Codable {
    let Value: Double
    let Unit: String
    let UnitType: Int
}
