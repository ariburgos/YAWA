//
//  HTTPConnector.swift
//  YAWA
//
//  Created by Viajeros Lado B on 24/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation

enum HTTPConnectorError : Error {
    case invalidRequest(statusCode: Int)
    case invalidResponse
    case dataError
    case jsonError
    case unknownError(error: Error?)
}

struct HTTPConnector {
    static let shared = HTTPConnector()
    private init() { }
    
    func fetchGenericData<T: Decodable> (url: URL, completion: @escaping (T?, HTTPConnectorError?) -> ()) {
        fetchData(url: url) { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, .dataError)
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj, nil)
            } catch let jsonError {
                print(jsonError)
                completion(nil, .jsonError)
            }
        }
    }
    
    func fetchData(url: URL, completion: @escaping (Data?, HTTPConnectorError?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Ups... there are a problem : \(error)")
                completion(nil, .unknownError(error: error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("there are a problem on the response")
                completion(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("the status code isn't 200, status code: \(response.statusCode)")
                completion(nil, .invalidRequest(statusCode: response.statusCode))
                return
            }
            
            guard let data = data else {
                completion(nil, .dataError)
                return
            }
            completion(data, nil)
            }.resume()
    }
}
