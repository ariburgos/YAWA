//
//  Forecast.swift
//  YAWA
//
//  Created by Viajeros Lado B on 24/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    let hourForecast: [HourForecast]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case hourForecast = "list"
        case city = "city"
    }
}
