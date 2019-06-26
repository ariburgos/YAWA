//
//  CityDetailsHeader.swift
//  YAWA
//
//  Created by Viajeros Lado B on 24/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class CityDetailsHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var cloudyLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    struct Constants {
        static let heightRow: CGFloat = 182
    }
    
    func configure(city: String, temperature: Float, date: String, tempMax: Float, tempMin: Float, cloud: Int, wind: Float) {
        cityLabel.text = city
        tempLabel.text = "\(Int(temperature)) °C"
        dateLabel.text = date
        tempMaxLabel.text = "\(Int(tempMax)) °C"
        tempMinLabel.text = "\(Int(tempMin)) °C"
        cloudyLabel.text = "\(cloud) %"
        windLabel.text = "\(wind) meter/sec"
    }
}
