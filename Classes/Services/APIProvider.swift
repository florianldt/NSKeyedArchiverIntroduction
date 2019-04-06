//
//  APIProvider.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 3/26/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct APIProvider {
    
    enum APIProviderError: Error {
        case somethingWentWrong

        var localizedDescription: String {
            switch self {
            case .somethingWentWrong:
                return NSLocalizedString("Something went wrong!", comment: "")
            }
        }
    }
    
    func loadTop50CitiesCurrentWeather(completionHandler: @escaping (APIResult<WeatherFeed>) -> ()) {
        
        // Replace ACCUWEATHER_API_KEY by your own API KEY -> https://developer.accuweather.com
        let url = "https://dataservice.accuweather.com/currentconditions/v1/topcities/50?apikey=" + ACCUWEATHER_API_KEY
        
        let urlConfig = URLSessionConfiguration.default
        urlConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        urlConfig.urlCache = nil
        
        let session = URLSession(configuration: urlConfig)
        
        session.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                guard let error = error else {
                    return completionHandler(.failure(APIProviderError.somethingWentWrong))
                }
                return completionHandler(.failure(error))
            }
            
            switch response.statusCode {
            case 200:
                do {
                    let topCityWeathers = try JSONDecoder().decode([TopCityWeather].self, from: data)
                    let weatherFeed = WeatherFeed(topCityWeathers: topCityWeathers)
                    completionHandler(.success(weatherFeed))
                } catch {
                    completionHandler(.failure(error))
                }
            default:
                do {
                    let accuWeatherError = try JSONDecoder().decode(AccuWeatherError.self, from: data)
                    completionHandler(.failure(accuWeatherError.toError(statusCode: response.statusCode)))
                } catch {
                    completionHandler(.failure(APIProviderError.somethingWentWrong))
                }
            }
            
        }.resume()
    }
    
}
