//
//  ForecastAPI.swift
//  YAWA
//
//  Created by Viajeros Lado B on 24/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation

//MARK: Implementation decision.
////It is correct if I would used MVP (so the Presenter would be the responsible for implement this)
////I decided go for MVC, so I left the responsibility of manage the error to the ViewController.
//protocol forecastPresenterProtocol: AnyObject {
//    func showError(title: String, message: String)
//    func showFerecastDetails(forecast: Forecast)
//}

struct ForecastAPI {
    static let shared = ForecastAPI()
    private init() {}
    
    struct Constants {
        static let apiKey = "d0746c8298972a2c3109469eeb8d2340"
        static let forecastURL = "https://api.openweathermap.org/data/2.5/forecast"
        static let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
        static let imageURL = "https://openweathermap.org/img/w/%@.png"
    }
    
    enum ForecastAPIError {
        case cityNotFound
        case noInternetConnection
        case genericError
    }
    
    
    func getForecastFor(city: String, completion: @escaping (CurrentWeather?, Forecast?, ForecastAPIError?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let queryItems = [URLQueryItem(name: "APPID", value: Constants.apiKey),
                              URLQueryItem(name: "q", value: city),
                              URLQueryItem(name: "mode", value: "json"),
                              URLQueryItem(name: "units", value: "metric"),
                              URLQueryItem(name: "cnt", value: "8")]
            let forecastURLComponent = NSURLComponents(string: Constants.forecastURL)!
            let currentWeatherURLComponent = NSURLComponents(string: Constants.currentWeatherURL)!
            forecastURLComponent.queryItems = queryItems
            currentWeatherURLComponent.queryItems = queryItems
            
            HTTPConnector.shared.fetchGenericData(url: forecastURLComponent.url!) { (forecast: Forecast?, forecastError: HTTPConnectorError?) in
                if let forecastError = forecastError {
                    self.handleError(error: forecastError, completion: completion)
                    return
                }
                
                HTTPConnector.shared.fetchGenericData(url: currentWeatherURLComponent.url!) { (currentWeather: CurrentWeather?, weatherError: HTTPConnectorError?) in
                    if let weatherError = weatherError {
                        self.handleError(error: weatherError, completion: completion)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(currentWeather, forecast, nil)
                    }
                }
            }
        }
    }
    
    private func handleError(error: HTTPConnectorError, completion: @escaping (CurrentWeather?, Forecast?, ForecastAPIError?) -> ()) {
        DispatchQueue.main.async {
            if case let .invalidRequest(code) = error,
                code == 404 {
                completion(nil, nil, .cityNotFound)
            }
                
            else if case let .unknownError(error) = error,
                let nsError = error as NSError?,
                nsError.code == -1009 {
                completion(nil, nil, .noInternetConnection)
            }
            else {
                completion(nil, nil, .genericError)
            }
        }
    }
    
    func getIcon(named: String, completion: @escaping (Data?, HTTPConnectorError?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            HTTPConnector.shared.fetchData(url: URL(string:String(format: Constants.imageURL, named))!) { (data: Data?, error: HTTPConnectorError?) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
        }
    }
}

