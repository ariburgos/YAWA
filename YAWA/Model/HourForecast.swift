//
//  HourForecast.swift
//  YAWA
//
//  Created by Viajeros Lado B on 26/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation

struct HourForecast: Decodable {
    let dt: Int
    let main: Temperature
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
}
