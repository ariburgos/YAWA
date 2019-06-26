//
//  Temperature.swift
//  YAWA
//
//  Created by Viajeros Lado B on 26/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation

struct Temperature: Decodable {
    let temp: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Float
    let humidity: Float
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}
