//
//  HourDetailViewController.swift
//  YAWA
//
//  Created by Viajeros Lado B on 24/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class HourDetailViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var hourForecast: HourForecast?
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let hourForecast = hourForecast,
            let weather = hourForecast.weather.first,
            let city = city else { return }
        
        cityLabel.text = city.name
        tempLabel.text = "\(String(Int(hourForecast.main.temp)))°"
        minTempLabel.text = "\(String(hourForecast.main.tempMin))°"
        maxTempLabel.text = "\(String(hourForecast.main.tempMax))°"
        descriptionLabel.text = weather.description
        dateLabel.text = Tools.unixTimestampToString(unixNumber: hourForecast.dt,
                                                     secondsFromGMT: city.timezone,
                                                     format: .dayMonthHourMinutes)
        windLabel.text = String(hourForecast.wind.speed)
        cloudsLabel.text = String(hourForecast.clouds.all)
        humidityLabel.text = String(Int(hourForecast.main.humidity))

        ImageManager.shared.getImageFromForecastAPI(named: weather.icon, completion: { [weak self] (image) in
            self?.icon.image = image
        })
    }
}
