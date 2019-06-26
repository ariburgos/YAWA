//
//  SearchViewController.swift
//  YAWA
//
//  Created by Viajeros Lado B on 24/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var cityTextfield: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        view.endEditing(true)

        guard let city = cityTextfield.text,
            !city.isEmpty else {
            alertEmptyTextView()
            return
        }
        
        showLoading()
        
        ForecastAPI.shared.getForecastFor(city: city) { [weak self] (currentWeather, forecast, error) in
            self?.stopLoading(completion: {
                if let error = error {
                    switch error {
                    case .cityNotFound:
                        self?.showMessageWithClose(title: "Error", message: "city not found")
                    case .noInternetConnection:
                        self?.showMessageWithClose(title: "Error", message: "The Internet connection appears to be offline")
                    default:
                        self?.showMessageWithClose(title: "Error", message: "Something is wrong")
                    }
                    return
                }
                
                guard let forecast = forecast,
                    let currentWeather = currentWeather else {
                        self?.showMessageWithClose(title: "Error", message: "There are not forecast")
                        return
                }
                
                self?.performSegue(withIdentifier: "showCityDetails", sender: (currentWeather,forecast))
                
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCityDetails",
            let cityDetailsViewController = segue.destination as? CityDetailsViewController,
            let (currentWeather,forecast) = sender as? (CurrentWeather,Forecast) {
                cityDetailsViewController.forecast = forecast
                cityDetailsViewController.currentWeather = currentWeather
            
        }
    }
    
    func alertEmptyTextView() {
        let hapticsGenerator = UINotificationFeedbackGenerator()
        hapticsGenerator.notificationOccurred(.warning)
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        cityTextfield.layer.add(animation, forKey: "shake")
    }
}
