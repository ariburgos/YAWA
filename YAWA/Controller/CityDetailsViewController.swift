//
//  CityDetailsViewController.swift
//  YAWA
//
//  Created by Viajeros Lado B on 24/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class CityDetailsViewController: UITableViewController {
    var forecast: Forecast?
    var currentWeather: CurrentWeather?
    
    struct Constants {
        static let rowHeight: CGFloat = 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false

        let headerNib = UINib.init(nibName: "CityDetailsHeader", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "CityDetailsHeader")
        
        // For removing the extra empty spaces of TableView below
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cityHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CityDetailsHeader") as! CityDetailsHeader
        
        if let currentWeather = currentWeather {
            cityHeaderView.configure(city: currentWeather.name,
                                     temperature: currentWeather.main.temp,
                                     date: Tools.unixTimestampToString(unixNumber: currentWeather.dt,
                                                                    secondsFromGMT: currentWeather.timezone,
                                                                    format: .fullDescription),
                                     tempMax: currentWeather.main.tempMax,
                                     tempMin: currentWeather.main.tempMin,
                                     cloud: currentWeather.clouds.all,
                                     wind: currentWeather.wind.speed)
        }
        return cityHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CityDetailsHeader.Constants.heightRow
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecast = forecast else { return 0 }
        return forecast.hourForecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hourDetailCell = tableView.dequeueReusableCell(withIdentifier: "hourDetailCell", for: indexPath) as! HourDetailTableViewCell
        if let forecast = forecast,
                let weather = forecast.hourForecast[indexPath.row].weather.first {
            hourDetailCell.dateLabel.text = Tools.unixTimestampToString(unixNumber: forecast.hourForecast[indexPath.row].dt,
                                                                        secondsFromGMT: forecast.city.timezone,
                                                                        format: .hourMinutes)
            hourDetailCell.tempLabel.text = "\(String(Int(forecast.hourForecast[indexPath.row].main.temp)))°"
            hourDetailCell.detailLabel.text = weather.description
        }
        return hourDetailCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let forecast = forecast else { return }
        performSegue(withIdentifier: "showHourDetail", sender: forecast.hourForecast[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHourDetail",
            let forecast = forecast,
            let hourForecast = sender as? HourForecast,
            let hourDetailViewController = segue.destination as? HourDetailViewController{
            hourDetailViewController.hourForecast = hourForecast
            hourDetailViewController.city = forecast.city
        }
    }
}
