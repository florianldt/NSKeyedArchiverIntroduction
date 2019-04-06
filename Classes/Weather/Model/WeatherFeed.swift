//
//  WeatherFeed.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 3/26/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct WeatherFeed: Codable {
    let fetchedAt: String
    var topCityWeathers: [TopCityWeather]
    
    static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df
    }
    
    init(topCityWeathers: [TopCityWeather]) {
        let now = Date()
        self.fetchedAt = WeatherFeed.dateFormatter.string(from: now)
        self.topCityWeathers = topCityWeathers
    }
}
