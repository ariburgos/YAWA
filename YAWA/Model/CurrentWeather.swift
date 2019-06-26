//
//  CurrentWeather.swift
//  YAWA
//
//  Created by Viajeros Lado B on 26/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let timezone: Int
    let dt: Int
    let name: String
    let weather: [Weather]
    let main: Temperature
    let wind: Wind
    let clouds: Clouds
}
