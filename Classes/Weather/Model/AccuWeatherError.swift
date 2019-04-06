//
//  AccuWeatherError.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 3/27/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct AccuWeatherError: Codable {
    let Code: String
    let Message: String
    
    
}

extension AccuWeatherError {
    func toError(statusCode code: Int) -> Error {
        let error = NSError(domain: "AccuWeather",
                            code: code,
                            userInfo: [
                                NSLocalizedDescriptionKey : "\(self.Code) | \(self.Message)"
            ])
        return error as Error
    }
}
