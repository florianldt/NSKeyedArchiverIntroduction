//
//  NSKeyedArchiverManager.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 3/26/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct NSKeyedArchiverManager {
    
    enum Paths {
        static let weatherFeed = "WeatherFeed"
    }
    
    static private func documentDirectory(with path: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory + "/" + path
    }
    
    static func archive<T: Encodable>(object: T, toFile path: String) throws {
        do {
            let data = try PropertyListEncoder().encode(object)
            NSKeyedArchiver.archiveRootObject(data, toFile: documentDirectory(with: path))
        } catch {
            throw error
        }
    }
    
    static func unarchive<T: Decodable>(fromFile path: String) throws -> T? {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: documentDirectory(with: path)) as? Data else { return nil }
        do {
            let result = try PropertyListDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw error
        }
    }
    
}
