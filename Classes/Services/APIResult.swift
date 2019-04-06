//
//  APIResult.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 4/6/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

enum APIResult<Value> {
    case success(Value)
    case failure(Error)
}
